#using scripts/shared/weapons/_weaponobjects;
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
#using scripts/shared/_burnplayer;
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
#using scripts/codescripts/struct;

#namespace namespace_648c84b6;

// Namespace namespace_648c84b6
// Params 0, eflags: 0x2
// Checksum 0xa241e276, Offset: 0xab8
// Size: 0x274
function init() {
    function_75050fc3();
    spawner::add_archetype_spawn_function("mechz", &function_4b03ba18);
    spawner::add_archetype_spawn_function("mechz", &namespace_e907cf54::function_13ea5d88);
    clientfield::register("actor", "mechz_ft", 5000, 1, "int");
    clientfield::register("actor", "mechz_faceplate_detached", 5000, 1, "int");
    clientfield::register("actor", "mechz_powercap_detached", 5000, 1, "int");
    clientfield::register("actor", "mechz_claw_detached", 5000, 1, "int");
    clientfield::register("actor", "mechz_115_gun_firing", 5000, 1, "int");
    clientfield::register("actor", "mechz_rknee_armor_detached", 5000, 1, "int");
    clientfield::register("actor", "mechz_lknee_armor_detached", 5000, 1, "int");
    clientfield::register("actor", "mechz_rshoulder_armor_detached", 5000, 1, "int");
    clientfield::register("actor", "mechz_lshoulder_armor_detached", 5000, 1, "int");
    clientfield::register("actor", "mechz_headlamp_off", 5000, 2, "int");
    clientfield::register("actor", "mechz_face", 1, 3, "int");
}

// Namespace namespace_648c84b6
// Params 0, eflags: 0x5 linked
// Checksum 0x33d94f30, Offset: 0xd38
// Size: 0x474
function function_75050fc3() {
    behaviortreenetworkutility::registerbehaviortreescriptapi("mechzTargetService", &mechztargetservice);
    behaviortreenetworkutility::registerbehaviortreescriptapi("mechzGrenadeService", &mechzgrenadeservice);
    behaviortreenetworkutility::registerbehaviortreescriptapi("mechzBerserkKnockdownService", &mechzberserkknockdownservice);
    behaviortreenetworkutility::registerbehaviortreescriptapi("mechzShouldMelee", &mechzshouldmelee);
    behaviortreenetworkutility::registerbehaviortreescriptapi("mechzShouldShowPain", &mechzshouldshowpain);
    behaviortreenetworkutility::registerbehaviortreescriptapi("mechzShouldShootGrenade", &mechzshouldshootgrenade);
    behaviortreenetworkutility::registerbehaviortreescriptapi("mechzShouldShootFlame", &mechzshouldshootflame);
    behaviortreenetworkutility::registerbehaviortreescriptapi("mechzShouldShootFlameSweep", &mechzshouldshootflamesweep);
    behaviortreenetworkutility::registerbehaviortreescriptapi("mechzShouldTurnBerserk", &mechzshouldturnberserk);
    behaviortreenetworkutility::registerbehaviortreescriptapi("mechzShouldStun", &function_61bf428d);
    behaviortreenetworkutility::registerbehaviortreescriptapi("mechzShouldStumble", &mechzshouldstumble);
    behaviortreenetworkutility::registerbehaviortreeaction("mechzStunLoop", &function_5ea3a844, &function_c65c7003, &function_7561480f);
    behaviortreenetworkutility::registerbehaviortreeaction("mechzStumbleLoop", &function_48571752, &function_76b932dd, &function_bcd1c0b9);
    behaviortreenetworkutility::registerbehaviortreeaction("mechzShootFlameAction", &function_82a18c9c, &function_993e2b, &function_bee98bb7);
    behaviortreenetworkutility::registerbehaviortreescriptapi("mechzShootGrenade", &function_f4e4ed65);
    behaviortreenetworkutility::registerbehaviortreescriptapi("mechzShootFlame", &mechzshootflame);
    behaviortreenetworkutility::registerbehaviortreescriptapi("mechzUpdateFlame", &mechzupdateflame);
    behaviortreenetworkutility::registerbehaviortreescriptapi("mechzStopFlame", &mechzstopflame);
    behaviortreenetworkutility::registerbehaviortreescriptapi("mechzPlayedBerserkIntro", &mechzplayedberserkintro);
    behaviortreenetworkutility::registerbehaviortreescriptapi("mechzAttackStart", &mechzattackstart);
    behaviortreenetworkutility::registerbehaviortreescriptapi("mechzDeathStart", &mechzdeathstart);
    behaviortreenetworkutility::registerbehaviortreescriptapi("mechzIdleStart", &mechzidlestart);
    behaviortreenetworkutility::registerbehaviortreescriptapi("mechzPainStart", &mechzpainstart);
    behaviortreenetworkutility::registerbehaviortreescriptapi("mechzPainTerminate", &mechzpainterminate);
    animationstatenetwork::registernotetrackhandlerfunction("melee_soldat", &function_bb8f6697);
    animationstatenetwork::registernotetrackhandlerfunction("fire_chaingun", &function_7dc77a24);
}

// Namespace namespace_648c84b6
// Params 0, eflags: 0x5 linked
// Checksum 0xc5e372b0, Offset: 0x11b8
// Size: 0x1ec
function function_4b03ba18() {
    blackboard::createblackboardforentity(self);
    self aiutility::function_89e1fc16();
    blackboard::registerblackboardattribute(self, "_locomotion_speed", "locomotion_speed_run", undefined);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("mechz_rknee_armor_detached");
        #/
    }
    blackboard::registerblackboardattribute(self, "_locomotion_should_turn", "should_not_turn", &bb_getshouldturn);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("mechz_rknee_armor_detached");
        #/
    }
    blackboard::registerblackboardattribute(self, "_zombie_damageweapon_type", "regular", undefined);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("mechz_rknee_armor_detached");
        #/
    }
    blackboard::registerblackboardattribute(self, "_mechz_part", "mechz_powercore", undefined);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("mechz_rknee_armor_detached");
        #/
    }
    self.___archetypeonanimscriptedcallback = &function_68c7b0ae;
    /#
        self finalizetrackedblackboardattributes();
    #/
}

// Namespace namespace_648c84b6
// Params 1, eflags: 0x5 linked
// Checksum 0xfdb8d738, Offset: 0x13b0
// Size: 0x34
function function_68c7b0ae(entity) {
    entity.__blackboard = undefined;
    entity function_4b03ba18();
}

// Namespace namespace_648c84b6
// Params 0, eflags: 0x5 linked
// Checksum 0x9c03dea5, Offset: 0x13f0
// Size: 0x2a
function bb_getshouldturn() {
    if (isdefined(self.should_turn) && self.should_turn) {
        return "should_turn";
    }
    return "should_not_turn";
}

// Namespace namespace_648c84b6
// Params 1, eflags: 0x5 linked
// Checksum 0xc5d808e, Offset: 0x1428
// Size: 0x4c
function function_bb8f6697(entity) {
    if (isdefined(entity.var_6f76d887)) {
        entity thread [[ entity.var_6f76d887 ]]();
    }
    entity melee();
}

// Namespace namespace_648c84b6
// Params 1, eflags: 0x5 linked
// Checksum 0x86a65d17, Offset: 0x1480
// Size: 0x2cc
function function_7dc77a24(entity) {
    if (!isdefined(entity.enemy)) {
        return;
    }
    var_4a19d30d = entity.enemy.origin;
    v_velocity = entity.enemy getvelocity();
    var_4a19d30d += v_velocity * 1.5;
    var_11ce58a4 = math::randomsign() * randomint(32);
    var_37d0d30d = math::randomsign() * randomint(32);
    target_pos = var_4a19d30d + (var_11ce58a4, var_37d0d30d, 0);
    dir = vectortoangles(target_pos - entity.origin);
    dir = anglestoforward(dir);
    launch_offset = dir * 5;
    var_ec8c0873 = entity gettagorigin("tag_gun_barrel2") + launch_offset;
    dist = distance(var_ec8c0873, target_pos);
    velocity = dir * dist;
    velocity += (0, 0, 120);
    val = 1;
    oldval = entity clientfield::get("mechz_115_gun_firing");
    if (oldval === val) {
        val = 0;
    }
    entity clientfield::set("mechz_115_gun_firing", val);
    entity magicgrenadetype(getweapon("electroball_grenade"), var_ec8c0873, velocity);
    playsoundatposition("wpn_grenade_fire_mechz", entity.origin);
}

// Namespace namespace_648c84b6
// Params 1, eflags: 0x1 linked
// Checksum 0xebf0c8f6, Offset: 0x1758
// Size: 0x268
function mechztargetservice(entity) {
    if (isdefined(entity.ignoreall) && entity.ignoreall) {
        return 0;
    }
    if (isdefined(entity.var_24971ab5)) {
        return 0;
    }
    player = zombie_utility::get_closest_valid_player(self.origin, self.ignore_player);
    entity.favoriteenemy = player;
    if (!isdefined(player) || player isnotarget()) {
        if (isdefined(entity.ignore_player)) {
            if (isdefined(level._should_skip_ignore_player_logic) && [[ level._should_skip_ignore_player_logic ]]()) {
                return;
            }
            entity.ignore_player = [];
        }
        /#
            if (isdefined(level.var_da353fa7) && level.var_da353fa7) {
                entity setgoal(entity.origin);
                return 0;
            }
        #/
        if (isdefined(level.no_target_override)) {
            [[ level.no_target_override ]](entity);
        } else {
            entity setgoal(entity.origin);
        }
        return 0;
    }
    if (isdefined(level.enemy_location_override_func)) {
        var_d1bd0948 = [[ level.enemy_location_override_func ]](entity, player);
        if (isdefined(var_d1bd0948)) {
            entity setgoal(var_d1bd0948);
            return 1;
        }
    }
    targetpos = getclosestpointonnavmesh(player.origin, 64, 30);
    if (isdefined(targetpos)) {
        entity setgoal(targetpos);
        return 1;
    }
    entity setgoal(entity.origin);
    return 0;
}

// Namespace namespace_648c84b6
// Params 1, eflags: 0x5 linked
// Checksum 0x9d66e638, Offset: 0x19c8
// Size: 0x100
function mechzgrenadeservice(entity) {
    if (!isdefined(entity.var_400b82a8)) {
        entity.var_400b82a8 = 0;
    }
    if (entity.var_400b82a8 >= 3) {
        if (gettime() > entity.var_6cfeff6f) {
            entity.var_400b82a8 = 0;
        }
    }
    if (isdefined(level.var_5069a5f6)) {
        level.var_5069a5f6 = array::remove_undefined(level.var_5069a5f6);
        var_8c4a2bbb = array::filter(level.var_5069a5f6, 0, &function_c823934d, entity);
        entity.var_ff8b61ea = var_8c4a2bbb.size;
        return;
    }
    entity.var_ff8b61ea = 0;
}

// Namespace namespace_648c84b6
// Params 2, eflags: 0x5 linked
// Checksum 0x8f624b3f, Offset: 0x1ad0
// Size: 0x34
function function_c823934d(grenade, mechz) {
    if (grenade.owner === mechz) {
        return true;
    }
    return false;
}

// Namespace namespace_648c84b6
// Params 1, eflags: 0x5 linked
// Checksum 0xc5d2d7a5, Offset: 0x1b10
// Size: 0x43a
function mechzberserkknockdownservice(entity) {
    velocity = entity getvelocity();
    var_43502fbc = 0.3;
    predicted_pos = entity.origin + velocity * var_43502fbc;
    move_dist_sq = distancesquared(predicted_pos, entity.origin);
    speed = move_dist_sq / var_43502fbc;
    if (speed >= 10) {
        a_zombies = getaiarchetypearray("zombie");
        var_abbab1d4 = array::filter(a_zombies, 0, &function_42500ed0, entity, predicted_pos);
        if (var_abbab1d4.size > 0) {
            foreach (zombie in var_abbab1d4) {
                zombie.knockdown = 1;
                zombie.knockdown_type = "knockdown_shoved";
                var_82b4832b = entity.origin - zombie.origin;
                var_cd6dddb4 = vectornormalize((var_82b4832b[0], var_82b4832b[1], 0));
                zombie_forward = anglestoforward(zombie.angles);
                zombie_forward_2d = vectornormalize((zombie_forward[0], zombie_forward[1], 0));
                zombie_right = anglestoright(zombie.angles);
                zombie_right_2d = vectornormalize((zombie_right[0], zombie_right[1], 0));
                dot = vectordot(var_cd6dddb4, zombie_forward_2d);
                if (dot >= 0.5) {
                    zombie.knockdown_direction = "front";
                    zombie.getup_direction = "getup_back";
                    continue;
                }
                if (dot < 0.5 && dot > -0.5) {
                    dot = vectordot(var_cd6dddb4, zombie_right_2d);
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
    }
}

// Namespace namespace_648c84b6
// Params 3, eflags: 0x5 linked
// Checksum 0x27164013, Offset: 0x1f58
// Size: 0x1c4
function function_42500ed0(zombie, mechz, predicted_pos) {
    if (zombie.knockdown === 1) {
        return false;
    }
    var_780bea21 = 2304;
    dist_sq = distancesquared(predicted_pos, zombie.origin);
    if (dist_sq > var_780bea21) {
        return false;
    }
    if (zombie.var_6f905818 === 1) {
        return false;
    }
    origin = mechz.origin;
    facing_vec = anglestoforward(mechz.angles);
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

// Namespace namespace_648c84b6
// Params 1, eflags: 0x1 linked
// Checksum 0x68ed31, Offset: 0x2128
// Size: 0xe6
function mechzshouldmelee(entity) {
    if (!isdefined(entity.enemy)) {
        return false;
    }
    if (distancesquared(entity.origin, entity.enemy.origin) > 12544) {
        return false;
    }
    if (isdefined(entity.enemy.usingvehicle) && entity.enemy.usingvehicle) {
        return true;
    }
    yaw = abs(zombie_utility::getyawtoenemy());
    if (yaw > 45) {
        return false;
    }
    return true;
}

// Namespace namespace_648c84b6
// Params 1, eflags: 0x5 linked
// Checksum 0x4653e3c0, Offset: 0x2218
// Size: 0x2c
function mechzshouldshowpain(entity) {
    if (entity.var_1c545167 === 1) {
        return true;
    }
    return false;
}

// Namespace namespace_648c84b6
// Params 1, eflags: 0x5 linked
// Checksum 0x47a72c52, Offset: 0x2250
// Size: 0x140
function mechzshouldshootgrenade(entity) {
    if (entity.berserk === 1) {
        return false;
    }
    if (entity.var_82b23a28 !== 1) {
        return false;
    }
    if (!isdefined(entity.favoriteenemy)) {
        return false;
    }
    if (entity.var_400b82a8 >= 3) {
        return false;
    }
    if (entity.var_ff8b61ea >= 9) {
        return false;
    }
    if (!entity namespace_e907cf54::function_1590f705()) {
        return false;
    }
    if (!entity cansee(entity.favoriteenemy)) {
        return false;
    }
    dist_sq = distancesquared(entity.origin, entity.favoriteenemy.origin);
    if (dist_sq < 62500 || dist_sq > 1440000) {
        return false;
    }
    return true;
}

// Namespace namespace_648c84b6
// Params 1, eflags: 0x5 linked
// Checksum 0xbbe24c5d, Offset: 0x2398
// Size: 0x1f8
function mechzshouldshootflame(entity) {
    /#
        if (isdefined(entity.var_8d96ebb6) && entity.var_8d96ebb6) {
            return true;
        }
    #/
    if (entity.berserk === 1) {
        return false;
    }
    if (isdefined(entity.var_ee93e137) && entity.var_ee93e137 && gettime() < entity.var_5cff5e58) {
        return true;
    }
    if (!isdefined(entity.favoriteenemy)) {
        return false;
    }
    if (entity.var_ee93e137 === 1 && entity.var_5cff5e58 <= gettime()) {
        return false;
    }
    if (entity.var_43025ce8 > gettime()) {
        return false;
    }
    if (!entity namespace_e907cf54::function_65b0f653(26, "tag_flamethrower_fx")) {
        return false;
    }
    dist_sq = distancesquared(entity.origin, entity.favoriteenemy.origin);
    if (dist_sq < 9216 || dist_sq > 50625) {
        return false;
    }
    can_see = bullettracepassed(entity.origin + (0, 0, 36), entity.favoriteenemy.origin + (0, 0, 36), 0, undefined);
    if (!can_see) {
        return false;
    }
    return true;
}

// Namespace namespace_648c84b6
// Params 1, eflags: 0x5 linked
// Checksum 0x4dfb1d87, Offset: 0x2598
// Size: 0x156
function mechzshouldshootflamesweep(entity) {
    if (entity.berserk === 1) {
        return false;
    }
    if (!mechzshouldshootflame(entity)) {
        return false;
    }
    if (randomint(100) > 10) {
        return false;
    }
    var_68ef9890 = 0;
    players = getplayers();
    foreach (player in players) {
        if (distance2dsquared(entity.origin, player.origin) < 10000) {
            var_68ef9890++;
        }
    }
    if (var_68ef9890 < 2) {
        return false;
    }
    return true;
}

// Namespace namespace_648c84b6
// Params 1, eflags: 0x5 linked
// Checksum 0xe898d1a1, Offset: 0x26f8
// Size: 0x44
function mechzshouldturnberserk(entity) {
    if (entity.berserk === 1 && entity.var_d5943b21 !== 1) {
        return true;
    }
    return false;
}

// Namespace namespace_648c84b6
// Params 1, eflags: 0x5 linked
// Checksum 0x86f0f149, Offset: 0x2748
// Size: 0x3a
function function_61bf428d(entity) {
    if (isdefined(entity.stun) && entity.stun) {
        return true;
    }
    return false;
}

// Namespace namespace_648c84b6
// Params 1, eflags: 0x5 linked
// Checksum 0x1a2651e1, Offset: 0x2790
// Size: 0x3a
function mechzshouldstumble(entity) {
    if (isdefined(entity.stumble) && entity.stumble) {
        return true;
    }
    return false;
}

// Namespace namespace_648c84b6
// Params 2, eflags: 0x4
// Checksum 0x548bd0bd, Offset: 0x27d8
// Size: 0x48
function function_dd564387(entity, asmstatename) {
    animationstatenetworkutility::requeststate(entity, asmstatename);
    entity.var_8e51d34c = gettime() + 3000;
    return 5;
}

// Namespace namespace_648c84b6
// Params 2, eflags: 0x4
// Checksum 0x2673e98c, Offset: 0x2828
// Size: 0x44
function function_41737dc4(entity, asmstatename) {
    if (!(isdefined(entity.var_c45cab8d) && entity.var_c45cab8d)) {
        return 4;
    }
    return 5;
}

// Namespace namespace_648c84b6
// Params 2, eflags: 0x5 linked
// Checksum 0x2f1a8bd6, Offset: 0x2878
// Size: 0x48
function function_5ea3a844(entity, asmstatename) {
    animationstatenetworkutility::requeststate(entity, asmstatename);
    entity.stuntime = gettime() + 500;
    return 5;
}

// Namespace namespace_648c84b6
// Params 2, eflags: 0x5 linked
// Checksum 0x35f1d3ca, Offset: 0x28c8
// Size: 0x32
function function_c65c7003(entity, asmstatename) {
    if (gettime() > entity.stuntime) {
        return 4;
    }
    return 5;
}

// Namespace namespace_648c84b6
// Params 2, eflags: 0x5 linked
// Checksum 0x7fea3d7b, Offset: 0x2908
// Size: 0x40
function function_7561480f(entity, asmstatename) {
    entity.stun = 0;
    entity.var_e12b0a6c = gettime() + 10000;
    return 4;
}

// Namespace namespace_648c84b6
// Params 2, eflags: 0x5 linked
// Checksum 0x4dbcb46b, Offset: 0x2950
// Size: 0x48
function function_48571752(entity, asmstatename) {
    animationstatenetworkutility::requeststate(entity, asmstatename);
    entity.var_b2d7954a = gettime() + 500;
    return 5;
}

// Namespace namespace_648c84b6
// Params 2, eflags: 0x5 linked
// Checksum 0x5747d9b9, Offset: 0x29a0
// Size: 0x32
function function_76b932dd(entity, asmstatename) {
    if (gettime() > entity.var_b2d7954a) {
        return 4;
    }
    return 5;
}

// Namespace namespace_648c84b6
// Params 2, eflags: 0x5 linked
// Checksum 0xf708103c, Offset: 0x29e0
// Size: 0x40
function function_bcd1c0b9(entity, asmstatename) {
    entity.stumble = 0;
    entity.var_e12b0a6c = gettime() + 10000;
    return 4;
}

// Namespace namespace_648c84b6
// Params 2, eflags: 0x1 linked
// Checksum 0x883dd19f, Offset: 0x2a28
// Size: 0x48
function function_82a18c9c(entity, asmstatename) {
    animationstatenetworkutility::requeststate(entity, asmstatename);
    mechzshootflame(entity);
    return 5;
}

// Namespace namespace_648c84b6
// Params 2, eflags: 0x1 linked
// Checksum 0x88e62f42, Offset: 0x2a78
// Size: 0x130
function function_993e2b(entity, asmstatename) {
    if (isdefined(entity.berserk) && entity.berserk) {
        mechzstopflame(entity);
        return 4;
    }
    if (isdefined(mechzshouldmelee(entity)) && mechzshouldmelee(entity)) {
        mechzstopflame(entity);
        return 4;
    }
    if (isdefined(entity.var_ee93e137) && entity.var_ee93e137) {
        if (isdefined(entity.var_5cff5e58) && gettime() > entity.var_5cff5e58) {
            mechzstopflame(entity);
            return 4;
        }
        mechzupdateflame(entity);
    }
    return 5;
}

// Namespace namespace_648c84b6
// Params 2, eflags: 0x1 linked
// Checksum 0x985a6238, Offset: 0x2bb0
// Size: 0x30
function function_bee98bb7(entity, asmstatename) {
    mechzstopflame(entity);
    return 4;
}

// Namespace namespace_648c84b6
// Params 1, eflags: 0x5 linked
// Checksum 0x52640d37, Offset: 0x2be8
// Size: 0x4c
function function_f4e4ed65(entity) {
    entity.var_400b82a8++;
    if (entity.var_400b82a8 >= 3) {
        entity.var_6cfeff6f = gettime() + 6000;
    }
}

// Namespace namespace_648c84b6
// Params 1, eflags: 0x5 linked
// Checksum 0x3f71caa2, Offset: 0x2c40
// Size: 0x24
function mechzshootflame(entity) {
    entity thread function_98ebddae();
}

// Namespace namespace_648c84b6
// Params 0, eflags: 0x5 linked
// Checksum 0x4d59c986, Offset: 0x2c70
// Size: 0x70
function function_98ebddae() {
    self endon(#"death");
    self notify(#"hash_98ebddae");
    self endon(#"hash_98ebddae");
    wait(0.3);
    self clientfield::set("mechz_ft", 1);
    self.var_ee93e137 = 1;
    self.var_5cff5e58 = gettime() + 2500;
}

// Namespace namespace_648c84b6
// Params 1, eflags: 0x5 linked
// Checksum 0x9828cf1d, Offset: 0x2ce8
// Size: 0x174
function mechzupdateflame(entity) {
    if (isdefined(level.var_9c0601a3)) {
        [[ level.var_9c0601a3 ]](entity);
    } else {
        players = getplayers();
        foreach (player in players) {
            if (!(isdefined(player.is_burning) && player.is_burning)) {
                if (player istouching(entity.var_ec9023a6)) {
                    if (isdefined(entity.var_9e0f068e)) {
                        player thread [[ entity.var_9e0f068e ]]();
                        continue;
                    }
                    player thread function_58121b44(entity);
                }
            }
        }
    }
    if (isdefined(level.var_749152c4)) {
        [[ level.var_749152c4 ]](entity);
    }
}

// Namespace namespace_648c84b6
// Params 1, eflags: 0x1 linked
// Checksum 0xc331eb5d, Offset: 0x2e68
// Size: 0xf8
function function_58121b44(mechz) {
    self endon(#"death");
    self endon(#"disconnect");
    if (!(isdefined(self.is_burning) && self.is_burning) && zombie_utility::is_player_valid(self, 1)) {
        self.is_burning = 1;
        if (!self hasperk("specialty_armorvest")) {
            self burnplayer::setplayerburning(1.5, 0.5, 30, mechz, undefined);
        } else {
            self burnplayer::setplayerburning(1.5, 0.5, 20, mechz, undefined);
        }
        wait(1.5);
        self.is_burning = 0;
    }
}

// Namespace namespace_648c84b6
// Params 1, eflags: 0x1 linked
// Checksum 0xa9cad245, Offset: 0x2f68
// Size: 0x72
function mechzstopflame(entity) {
    self notify(#"hash_98ebddae");
    entity clientfield::set("mechz_ft", 0);
    entity.var_ee93e137 = 0;
    entity.var_43025ce8 = gettime() + 7500;
    entity.var_5cff5e58 = undefined;
}

// Namespace namespace_648c84b6
// Params 0, eflags: 0x1 linked
// Checksum 0xdd71ac10, Offset: 0x2fe8
// Size: 0xa4
function function_bd447f24() {
    entity = self;
    g_time = gettime();
    entity.var_b1f797a7 = g_time + 10000;
    if (entity.berserk !== 1) {
        entity.berserk = 1;
        entity thread function_30b61b5f();
        blackboard::setblackboardattribute(entity, "_locomotion_speed", "locomotion_speed_sprint");
    }
}

// Namespace namespace_648c84b6
// Params 1, eflags: 0x5 linked
// Checksum 0x3bf96614, Offset: 0x3098
// Size: 0x20
function mechzplayedberserkintro(entity) {
    entity.var_d5943b21 = 1;
}

// Namespace namespace_648c84b6
// Params 0, eflags: 0x5 linked
// Checksum 0x2a1e43b4, Offset: 0x30c0
// Size: 0xa8
function function_30b61b5f() {
    self endon(#"death");
    self endon(#"disconnect");
    while (self.berserk === 1) {
        if (gettime() >= self.var_b1f797a7) {
            self.berserk = 0;
            self.var_d5943b21 = 0;
            self asmsetanimationrate(1);
            blackboard::setblackboardattribute(self, "_locomotion_speed", "locomotion_speed_run");
        }
        wait(0.25);
    }
}

// Namespace namespace_648c84b6
// Params 1, eflags: 0x5 linked
// Checksum 0x660f1fb7, Offset: 0x3170
// Size: 0x2c
function mechzattackstart(entity) {
    entity clientfield::set("mechz_face", 1);
}

// Namespace namespace_648c84b6
// Params 1, eflags: 0x5 linked
// Checksum 0x4c604890, Offset: 0x31a8
// Size: 0x2c
function mechzdeathstart(entity) {
    entity clientfield::set("mechz_face", 2);
}

// Namespace namespace_648c84b6
// Params 1, eflags: 0x5 linked
// Checksum 0x6631c3c4, Offset: 0x31e0
// Size: 0x2c
function mechzidlestart(entity) {
    entity clientfield::set("mechz_face", 3);
}

// Namespace namespace_648c84b6
// Params 1, eflags: 0x5 linked
// Checksum 0xf4f64d0d, Offset: 0x3218
// Size: 0x2c
function mechzpainstart(entity) {
    entity clientfield::set("mechz_face", 4);
}

// Namespace namespace_648c84b6
// Params 1, eflags: 0x5 linked
// Checksum 0xb2d5b22a, Offset: 0x3250
// Size: 0x2a
function mechzpainterminate(entity) {
    entity.var_1c545167 = 0;
    entity.var_77116375 = undefined;
}

#namespace namespace_e907cf54;

// Namespace namespace_e907cf54
// Params 0, eflags: 0x5 linked
// Checksum 0x83d7ab87, Offset: 0x3288
// Size: 0x1f2
function function_13ea5d88() {
    self disableaimassist();
    self.disableammodrop = 1;
    self.no_gib = 1;
    self.ignore_nuke = 1;
    self.ignore_enemy_count = 1;
    self.var_833cfbae = 1;
    self.zombie_move_speed = "run";
    blackboard::setblackboardattribute(self, "_locomotion_speed", "locomotion_speed_run");
    self.ignorerunandgundist = 1;
    self function_9fd43abd();
    self.grenadecount = 9;
    self.var_43025ce8 = gettime();
    self.var_e12b0a6c = gettime();
    /#
        self.debug_traversal_ast = "mechz_rknee_armor_detached";
    #/
    self.var_ec9023a6 = spawn("trigger_box", self.origin, 0, -56, 50, 25);
    self.var_ec9023a6 enablelinkto();
    self.var_ec9023a6.origin = self gettagorigin("tag_flamethrower_fx");
    self.var_ec9023a6.angles = self gettagangles("tag_flamethrower_fx");
    self.var_ec9023a6 linkto(self, "tag_flamethrower_fx");
    self thread weaponobjects::watchweaponobjectusage();
    self.pers = [];
    self.pers["team"] = self.team;
}

// Namespace namespace_e907cf54
// Params 0, eflags: 0x4
// Checksum 0x7c76025e, Offset: 0x3488
// Size: 0x70
function function_5cd35d77() {
    self endon(#"death");
    while (true) {
        if (isdefined(self.favoriteenemy)) {
            if (self.var_ec9023a6 istouching(self.favoriteenemy)) {
                /#
                    printtoprightln("mechz_rknee_armor_detached");
                #/
            }
        }
        wait(0.05);
    }
}

// Namespace namespace_e907cf54
// Params 0, eflags: 0x5 linked
// Checksum 0xbf0bb662, Offset: 0x3500
// Size: 0x10c
function function_9fd43abd() {
    self.var_abc28c49 = 1;
    self.var_ec94e7b9 = 50;
    self.var_3b950b2e = 1;
    self.var_bf2b21ce = 50;
    self.var_6f97a2a8 = 1;
    self.var_51a5fb0a = 50;
    self.var_d469243b = 1;
    self.var_88897a65 = 50;
    org = self gettagorigin("tag_gun_spin");
    ang = self gettagangles("tag_gun_spin");
    self.var_82b23a28 = 1;
    self.var_aba6456b = 1;
    self.var_b087942f = 50;
    self.var_6d2e297f = 1;
    self.var_41505d43 = 1;
    self.var_a59d71f5 = 50;
    self.var_88b6008d = 50;
}

// Namespace namespace_e907cf54
// Params 12, eflags: 0x1 linked
// Checksum 0x690f974a, Offset: 0x3618
// Size: 0x16b4
function function_2670d89e(inflictor, attacker, damage, dflags, mod, weapon, point, dir, hitloc, offsettime, boneindex, modelindex) {
    if (isdefined(self.var_a1c73f09) && !(isdefined(self.var_a1c73f09) && self.var_a1c73f09)) {
        return 0;
    }
    if (isdefined(level.var_eabb03e4) && !(isdefined(self.stumble) && (isdefined(self.stun) && self.stun || self.stumble))) {
        if (self.var_e12b0a6c < gettime() && !(isdefined(self.berserk) && self.berserk)) {
            self [[ level.var_eabb03e4 ]](inflictor, attacker, damage, dflags, mod, weapon, point, dir, hitloc, offsettime, boneindex, modelindex);
        }
    }
    if (issubstr(weapon.name, "elemental_bow") && isdefined(inflictor) && inflictor.classname === "rocket") {
        return 0;
    }
    damage = function_601ff508(damage, weapon);
    if (isdefined(level.var_a8588ff)) {
        damage = [[ level.var_a8588ff ]](attacker, damage);
    }
    if (!isdefined(self.var_15207123) || gettime() >= self.var_15207123) {
        self thread function_c79a7e57();
        self.var_15207123 = gettime() + -6 + randomint(500);
    }
    if (isdefined(self.var_fc8ce4cb)) {
        self [[ self.var_fc8ce4cb ]](inflictor, attacker, damage, dflags, mod, weapon, point, dir, hitloc, offsettime, boneindex, modelindex);
    }
    if (isdefined(level.var_c8cf79a8)) {
        var_3e32b9de = [[ level.var_c8cf79a8 ]](inflictor, attacker, damage, dflags, mod, weapon, point, dir, hitloc, offsettime, boneindex, modelindex);
        if (var_3e32b9de > 0) {
            var_ec7c92e3 = 0.5;
            if (!(isdefined(self.var_aba6456b) && self.var_aba6456b) && var_ec7c92e3 < 1) {
                var_ec7c92e3 = 1;
            }
            var_3e32b9de *= var_ec7c92e3;
            if (isdefined(self.var_aba6456b) && self.var_aba6456b) {
                self function_b024a4c(var_3e32b9de);
            }
            /#
                iprintlnbold("mechz_rknee_armor_detached" + var_3e32b9de + "mechz_rknee_armor_detached" + self.health - var_3e32b9de);
            #/
            if (!isdefined(self.var_5ad1fcf3)) {
                self.var_5ad1fcf3 = 0;
            }
            self.var_5ad1fcf3 += var_3e32b9de;
            if (isdefined(level.var_78fafa94)) {
                self [[ level.var_78fafa94 ]]();
            }
            return var_3e32b9de;
        }
    }
    if (isdefined(level.var_78fafa94)) {
        if (isdefined(mod) && mod == "MOD_GRENADE" || mod == "MOD_GRENADE_SPLASH" || mod == "MOD_PROJECTILE" || mod == "MOD_PROJECTILE_SPLASH" || mod == "MOD_EXPLOSIVE") {
            var_8a8ce110 = 0.5;
            if (isdefined(attacker.personal_instakill) && (level.zombie_vars[attacker.team]["zombie_insta_kill"] || isdefined(attacker) && isplayer(attacker) && isalive(attacker) && attacker.personal_instakill)) {
                var_8a8ce110 = 1;
            }
            explosive_damage = damage * var_8a8ce110;
            if (!isdefined(self.var_5ad1fcf3)) {
                self.var_5ad1fcf3 = 0;
            }
            self.var_5ad1fcf3 += explosive_damage;
            if (isdefined(self.var_aba6456b) && self.var_aba6456b) {
                self function_b024a4c(explosive_damage);
            }
            self [[ level.var_78fafa94 ]]();
            /#
                iprintlnbold("mechz_rknee_armor_detached" + explosive_damage + "mechz_rknee_armor_detached" + self.health - explosive_damage);
            #/
            return explosive_damage;
        }
    }
    if (hitloc == "head") {
        attacker show_hit_marker();
        /#
            iprintlnbold("mechz_rknee_armor_detached" + damage + "mechz_rknee_armor_detached" + self.health - damage);
        #/
        return damage;
    }
    if (hitloc !== "none") {
        switch (hitloc) {
        case 91:
            if (self.var_aba6456b == 1) {
                var_2700f09 = self gettagorigin("j_faceplate");
                dist_sq = distancesquared(var_2700f09, point);
                if (dist_sq <= -112) {
                    self function_b024a4c(damage);
                    attacker show_hit_marker();
                }
                var_178d0187 = distancesquared(point, self gettagorigin("tag_headlamp_FX"));
                if (var_178d0187 <= 9) {
                    self function_378d99af(1);
                }
            }
            partname = getpartname("c_zom_mech_body", boneindex);
            if (partname === "tag_powersupply" || self.var_41505d43 === 1 && partname === "tag_powersupply_hit") {
                self function_ff3f6e(damage);
                attacker show_hit_marker();
                /#
                    iprintlnbold("mechz_rknee_armor_detached" + damage * 0.1 + "mechz_rknee_armor_detached" + self.health - damage * 0.1);
                #/
                return (damage * 0.1);
            } else if (partname === "tag_powersupply" || self.var_41505d43 !== 1 && self.var_6d2e297f === 1 && partname === "tag_powersupply_hit") {
                self function_81c30baa(damage);
                attacker show_hit_marker();
                /#
                    iprintlnbold("mechz_rknee_armor_detached" + damage + "mechz_rknee_armor_detached" + self.health - damage);
                #/
                return damage;
            } else if (partname === "tag_powersupply" || self.var_41505d43 !== 1 && self.var_6d2e297f !== 1 && partname === "tag_powersupply_hit") {
                /#
                    iprintlnbold("mechz_rknee_armor_detached" + damage * 0.5 + "mechz_rknee_armor_detached" + self.health - damage * 0.5);
                #/
                attacker show_hit_marker();
                return (damage * 0.5);
            }
            if (self.var_d469243b === 1 && partname === "j_shoulderarmor_ri") {
                self function_b7934265(damage);
                /#
                    iprintlnbold("mechz_rknee_armor_detached" + damage * 0.1 + "mechz_rknee_armor_detached" + self.health - damage * 0.1);
                #/
                return (damage * 0.1);
            }
            if (self.var_6f97a2a8 === 1 && partname === "j_shoulderarmor_le") {
                self function_75493757(damage);
                /#
                    iprintlnbold("mechz_rknee_armor_detached" + damage * 0.1 + "mechz_rknee_armor_detached" + self.health - damage * 0.1);
                #/
                return (damage * 0.1);
            }
            /#
                iprintlnbold("mechz_rknee_armor_detached" + damage * 0.1 + "mechz_rknee_armor_detached" + self.health - damage * 0.1);
            #/
            return (damage * 0.1);
        case 89:
            partname = getpartname("c_zom_mech_body", boneindex);
            if (partname === "j_knee_attach_le" && self.var_abc28c49 === 1) {
                self function_68a38e0(damage);
            }
            /#
                iprintlnbold("mechz_rknee_armor_detached" + damage * 0.1 + "mechz_rknee_armor_detached" + self.health - damage * 0.1);
            #/
            return (damage * 0.1);
        case 90:
            partname = getpartname("c_zom_mech_body", boneindex);
            if (partname === "j_knee_attach_ri" && self.var_3b950b2e === 1) {
                self function_1f360652(damage);
            }
            /#
                iprintlnbold("mechz_rknee_armor_detached" + damage * 0.1 + "mechz_rknee_armor_detached" + self.health - damage * 0.1);
            #/
            return (damage * 0.1);
        case 86:
        case 87:
        case 88:
            if (isdefined(level.var_ca204e3d)) {
                self [[ level.var_ca204e3d ]]();
            }
            /#
                iprintlnbold("mechz_rknee_armor_detached" + damage * 0.1 + "mechz_rknee_armor_detached" + self.health - damage * 0.1);
            #/
            return (damage * 0.1);
        default:
            /#
                iprintlnbold("mechz_rknee_armor_detached" + damage * 0.1 + "mechz_rknee_armor_detached" + self.health - damage * 0.1);
            #/
            return (damage * 0.1);
        }
    }
    if (mod == "MOD_PROJECTILE") {
        hit_damage = damage * 0.1;
        if (self.var_aba6456b !== 1) {
            head_pos = self gettagorigin("tag_eye");
            dist_sq = distancesquared(head_pos, point);
            if (dist_sq <= -112) {
                /#
                    iprintlnbold("mechz_rknee_armor_detached" + damage + "mechz_rknee_armor_detached" + self.health - damage);
                #/
                attacker show_hit_marker();
                return damage;
            }
        }
        if (self.var_aba6456b === 1) {
            var_2700f09 = self gettagorigin("j_faceplate");
            dist_sq = distancesquared(var_2700f09, point);
            if (dist_sq <= -112) {
                self function_b024a4c(damage);
                attacker show_hit_marker();
            }
            var_178d0187 = distancesquared(point, self gettagorigin("tag_headlamp_FX"));
            if (var_178d0187 <= 9) {
                self function_378d99af(1);
            }
        }
        var_b8eb4fc3 = self gettagorigin("tag_powersupply_hit");
        var_2a8c0bea = distancesquared(var_b8eb4fc3, point);
        if (var_2a8c0bea <= 25) {
            if (self.var_41505d43 !== 1 && self.var_6d2e297f !== 1) {
                /#
                    iprintlnbold("mechz_rknee_armor_detached" + damage + "mechz_rknee_armor_detached" + self.health - damage);
                #/
                attacker show_hit_marker();
                return damage;
            }
            if (self.var_41505d43 !== 1 && self.var_6d2e297f === 1) {
                self function_81c30baa(damage);
                attacker show_hit_marker();
                /#
                    iprintlnbold("mechz_rknee_armor_detached" + damage + "mechz_rknee_armor_detached" + self.health - damage);
                #/
                return damage;
            }
            if (self.var_41505d43 === 1) {
                self function_ff3f6e(damage);
                attacker show_hit_marker();
            }
        }
        if (self.var_d469243b === 1) {
            var_35fb6271 = self gettagorigin("j_shoulderarmor_ri");
            dist_sq = distancesquared(var_35fb6271, point);
            if (dist_sq <= 64) {
                self function_b7934265(damage);
            }
        }
        if (self.var_6f97a2a8 === 1) {
            var_35fb6271 = self gettagorigin("j_shoulderarmor_le");
            dist_sq = distancesquared(var_35fb6271, point);
            if (dist_sq <= 64) {
                self function_75493757(damage);
            }
        }
        if (self.var_3b950b2e === 1) {
            var_35fb6271 = self gettagorigin("j_knee_attach_ri");
            dist_sq = distancesquared(var_35fb6271, point);
            if (dist_sq <= 36) {
                self function_1f360652(damage);
            }
        }
        if (self.var_abc28c49 === 1) {
            var_35fb6271 = self gettagorigin("j_knee_attach_le");
            dist_sq = distancesquared(var_35fb6271, point);
            if (dist_sq <= 36) {
                self function_68a38e0(damage);
            }
        }
        /#
            iprintlnbold("mechz_rknee_armor_detached" + hit_damage + "mechz_rknee_armor_detached" + self.health - hit_damage);
        #/
        return hit_damage;
    } else if (mod == "MOD_PROJECTILE_SPLASH") {
        hit_damage = damage * 0.2;
        var_e3cac4b3 = 0;
        if (isdefined(level.var_cc79df2f)) {
            self [[ level.var_cc79df2f ]](inflictor, attacker, damage, dflags, mod, weapon, point, dir, hitloc, offsettime, boneindex, modelindex);
        }
        if (self.var_d469243b === 1) {
            var_e3cac4b3 += 1;
            var_b5b3c52d = var_e3cac4b3;
        }
        if (self.var_6f97a2a8 === 1) {
            var_e3cac4b3 += 1;
            var_570b1d24 = var_e3cac4b3;
        }
        if (self.var_3b950b2e === 1) {
            var_e3cac4b3 += 1;
            var_4fa265d8 = var_e3cac4b3;
        }
        if (self.var_abc28c49 === 1) {
            var_e3cac4b3 += 1;
            var_dff45211 = var_e3cac4b3;
        }
        if (var_e3cac4b3 > 0) {
            if (var_e3cac4b3 <= 1) {
                i_random = 0;
            } else {
                i_random = randomint(var_e3cac4b3 - 1);
            }
            i_random += 1;
            if (self.var_d469243b === 1 && var_b5b3c52d === i_random) {
                self function_b7934265(damage);
            }
            if (self.var_6f97a2a8 === 1 && var_570b1d24 === i_random) {
                self function_75493757(damage);
            }
            if (self.var_3b950b2e === 1 && var_4fa265d8 === i_random) {
                self function_1f360652(damage);
            }
            if (self.var_abc28c49 === 1 && var_dff45211 === i_random) {
                self function_68a38e0(damage);
            }
        } else {
            if (self.var_41505d43 === 1) {
                self function_ff3f6e(damage * 0.5);
            }
            if (self.var_aba6456b == 1) {
                self function_b024a4c(damage * 0.5);
            }
        }
        /#
            iprintlnbold("mechz_rknee_armor_detached" + hit_damage + "mechz_rknee_armor_detached" + self.health - hit_damage);
        #/
        return hit_damage;
    }
    return 0;
}

// Namespace namespace_e907cf54
// Params 2, eflags: 0x5 linked
// Checksum 0xc06bdf2f, Offset: 0x4cd8
// Size: 0x14a
function function_601ff508(damage, weapon) {
    if (isdefined(weapon) && isdefined(weapon.name)) {
        if (issubstr(weapon.name, "shotgun_fullauto")) {
            return (damage * 0.5);
        }
        if (issubstr(weapon.name, "lmg_cqb")) {
            return (damage * 0.65);
        }
        if (issubstr(weapon.name, "lmg_heavy")) {
            return (damage * 0.65);
        }
        if (issubstr(weapon.name, "shotgun_precision")) {
            return (damage * 0.65);
        }
        if (issubstr(weapon.name, "shotgun_semiauto")) {
            return (damage * 0.75);
        }
    }
    return damage;
}

// Namespace namespace_e907cf54
// Params 0, eflags: 0x1 linked
// Checksum 0xa5e536ca, Offset: 0x4e30
// Size: 0x24
function function_c79a7e57() {
    self playsound("zmb_ai_mechz_destruction");
}

// Namespace namespace_e907cf54
// Params 0, eflags: 0x1 linked
// Checksum 0x66f41b19, Offset: 0x4e60
// Size: 0x88
function show_hit_marker() {
    if (isdefined(self) && isdefined(self.hud_damagefeedback)) {
        self.hud_damagefeedback setshader("damage_feedback", 24, 48);
        self.hud_damagefeedback.alpha = 1;
        self.hud_damagefeedback fadeovertime(1);
        self.hud_damagefeedback.alpha = 0;
    }
}

// Namespace namespace_e907cf54
// Params 1, eflags: 0x1 linked
// Checksum 0x809ea9df, Offset: 0x4ef0
// Size: 0x3c
function hide_part(var_9c42612) {
    if (self haspart(var_9c42612)) {
        self hidepart(var_9c42612);
    }
}

// Namespace namespace_e907cf54
// Params 1, eflags: 0x1 linked
// Checksum 0x47d1ba10, Offset: 0x4f38
// Size: 0xe2
function function_b024a4c(damage) {
    self.var_b087942f -= damage;
    if (self.var_b087942f <= 0) {
        self hide_part("j_faceplate");
        self clientfield::set("mechz_faceplate_detached", 1);
        self.var_aba6456b = 0;
        self function_378d99af();
        self.var_1c545167 = 1;
        blackboard::setblackboardattribute(self, "_mechz_part", "mechz_faceplate");
        self namespace_648c84b6::function_bd447f24();
        level notify(#"mechz_faceplate_detached");
    }
}

// Namespace namespace_e907cf54
// Params 1, eflags: 0x1 linked
// Checksum 0x6a0d5b24, Offset: 0x5028
// Size: 0xac
function function_ff3f6e(damage) {
    self.var_a59d71f5 -= damage;
    if (self.var_a59d71f5 <= 0) {
        self hide_part("tag_powersupply");
        self clientfield::set("mechz_powercap_detached", 1);
        self.var_41505d43 = 0;
        self.var_1c545167 = 1;
        blackboard::setblackboardattribute(self, "_mechz_part", "mechz_powercore");
    }
}

// Namespace namespace_e907cf54
// Params 1, eflags: 0x1 linked
// Checksum 0x6208f9b8, Offset: 0x50e0
// Size: 0x1a2
function function_81c30baa(damage) {
    self.var_88b6008d -= damage;
    if (self.var_88b6008d <= 0) {
        if (isdefined(level.var_48d0c948)) {
            self [[ level.var_48d0c948 ]]();
        }
        self hide_part("tag_gun_spin");
        self hide_part("tag_gun_barrel1");
        self hide_part("tag_gun_barrel2");
        self hide_part("tag_gun_barrel3");
        self hide_part("tag_gun_barrel4");
        self hide_part("tag_gun_barrel5");
        self hide_part("tag_gun_barrel6");
        self clientfield::set("mechz_claw_detached", 1);
        self.var_6d2e297f = 0;
        self.var_82b23a28 = 0;
        self.var_1c545167 = 1;
        blackboard::setblackboardattribute(self, "_mechz_part", "mechz_gun");
        level notify(#"hash_19eedb70");
    }
}

// Namespace namespace_e907cf54
// Params 1, eflags: 0x1 linked
// Checksum 0x5a9426f1, Offset: 0x5290
// Size: 0x78
function function_1f360652(damage) {
    self.var_bf2b21ce -= damage;
    if (self.var_bf2b21ce <= 0) {
        self hide_part("j_knee_attach_ri");
        self clientfield::set("mechz_rknee_armor_detached", 1);
        self.var_3b950b2e = 0;
    }
}

// Namespace namespace_e907cf54
// Params 1, eflags: 0x1 linked
// Checksum 0x71910697, Offset: 0x5310
// Size: 0x78
function function_68a38e0(damage) {
    self.var_ec94e7b9 -= damage;
    if (self.var_ec94e7b9 <= 0) {
        self hide_part("j_knee_attach_le");
        self clientfield::set("mechz_lknee_armor_detached", 1);
        self.var_abc28c49 = 0;
    }
}

// Namespace namespace_e907cf54
// Params 1, eflags: 0x1 linked
// Checksum 0xddd26758, Offset: 0x5390
// Size: 0x78
function function_b7934265(damage) {
    self.var_88897a65 -= damage;
    if (self.var_88897a65 <= 0) {
        self hide_part("j_shoulderarmor_ri");
        self clientfield::set("mechz_rshoulder_armor_detached", 1);
        self.var_d469243b = 0;
    }
}

// Namespace namespace_e907cf54
// Params 1, eflags: 0x1 linked
// Checksum 0x38e7245d, Offset: 0x5410
// Size: 0x78
function function_75493757(damage) {
    self.var_51a5fb0a -= damage;
    if (self.var_51a5fb0a <= 0) {
        self hide_part("j_shoulderarmor_le");
        self clientfield::set("mechz_lshoulder_armor_detached", 1);
        self.var_6f97a2a8 = 0;
    }
}

// Namespace namespace_e907cf54
// Params 2, eflags: 0x1 linked
// Checksum 0x603f88af, Offset: 0x5490
// Size: 0x224
function function_65b0f653(var_10946bf5, aim_tag) {
    origin = self.origin;
    angles = self.angles;
    if (isdefined(aim_tag)) {
        origin = self gettagorigin(aim_tag);
        angles = self gettagangles(aim_tag);
    }
    if (isdefined(var_10946bf5)) {
        var_f32a3315 = anglestoright(angles);
        origin += var_f32a3315 * var_10946bf5;
    }
    facing_vec = anglestoforward(angles);
    enemy_vec = self.favoriteenemy.origin - origin;
    var_ef095088 = (enemy_vec[0], enemy_vec[1], 0);
    var_331bc04c = (facing_vec[0], facing_vec[1], 0);
    var_ef095088 = vectornormalize(var_ef095088);
    var_331bc04c = vectornormalize(var_331bc04c);
    enemy_dot = vectordot(var_331bc04c, var_ef095088);
    if (enemy_dot < 0.5) {
        return false;
    }
    var_c15c560e = vectortoangles(enemy_vec);
    if (abs(angleclamp180(var_c15c560e[0])) > 60) {
        return false;
    }
    return true;
}

// Namespace namespace_e907cf54
// Params 1, eflags: 0x5 linked
// Checksum 0x51dedcce, Offset: 0x56c0
// Size: 0x1c4
function function_1590f705(var_10946bf5) {
    origin = self.origin;
    if (isdefined(var_10946bf5)) {
        var_f32a3315 = anglestoright(self.angles);
        origin += var_f32a3315 * var_10946bf5;
    }
    facing_vec = anglestoforward(self.angles);
    enemy_vec = self.favoriteenemy.origin - origin;
    var_ef095088 = (enemy_vec[0], enemy_vec[1], 0);
    var_331bc04c = (facing_vec[0], facing_vec[1], 0);
    var_ef095088 = vectornormalize(var_ef095088);
    var_331bc04c = vectornormalize(var_331bc04c);
    enemy_dot = vectordot(var_331bc04c, var_ef095088);
    if (enemy_dot < 0.5) {
        return false;
    }
    var_c15c560e = vectortoangles(enemy_vec);
    if (abs(angleclamp180(var_c15c560e[0])) > 60) {
        return false;
    }
    return true;
}

// Namespace namespace_e907cf54
// Params 1, eflags: 0x1 linked
// Checksum 0x2830c23d, Offset: 0x5890
// Size: 0x64
function function_378d99af(var_1423a95b) {
    if (var_1423a95b !== 1) {
        self clientfield::set("mechz_headlamp_off", 1);
        return;
    }
    self clientfield::set("mechz_headlamp_off", 2);
}

