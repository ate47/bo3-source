#using scripts/zm/_zm_weap_idgun;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_devgui;
#using scripts/zm/_zm_behavior;
#using scripts/zm/_zm_ai_wasp;
#using scripts/zm/_zm;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/margwa;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/systems/animation_state_machine_utility;
#using scripts/shared/util_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/math_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/aat_shared;
#using scripts/codescripts/struct;

#namespace namespace_ca5ef87d;

// Namespace namespace_ca5ef87d
// Params 0, eflags: 0x2
// Checksum 0x79b29f7, Offset: 0x670
// Size: 0x1ac
function autoexec init() {
    function_e84ffe9c();
    level.var_b398aafa = getentarray("zombie_margwa_spawner", "script_noteworthy");
    level.var_95810297 = struct::get_array("margwa_location", "script_noteworthy");
    level thread aat::register_immunity("zm_aat_blast_furnace", "margwa", 0, 1, 1);
    level thread aat::register_immunity("zm_aat_dead_wire", "margwa", 1, 1, 1);
    level thread aat::register_immunity("zm_aat_fire_works", "margwa", 1, 1, 1);
    level thread aat::register_immunity("zm_aat_thunder_wall", "margwa", 0, 1, 1);
    level thread aat::register_immunity("zm_aat_turned", "margwa", 1, 1, 1);
    spawner::add_archetype_spawn_function("margwa", &function_17627e34);
    /#
        execdevgui("zm_aat_turned");
        thread function_cdd8baf7();
    #/
}

// Namespace namespace_ca5ef87d
// Params 0, eflags: 0x0
// Checksum 0xf5bcdacb, Offset: 0x828
// Size: 0x92
function function_4092fa4d() {
    wait(20);
    for (i = 0; i < 1; i++) {
        var_2dcff864 = arraygetclosest(level.players[0].origin, level.var_95810297);
        margwa = function_8a0708c2(var_2dcff864);
        wait(0.5);
    }
}

// Namespace namespace_ca5ef87d
// Params 0, eflags: 0x5 linked
// Checksum 0x8f7013ee, Offset: 0x8c8
// Size: 0x28c
function private function_e84ffe9c() {
    behaviortreenetworkutility::registerbehaviortreescriptapi("zmMargwaTargetService", &function_c0fb414e);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zmMargwaTeleportService", &function_5d11b2dc);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zmMargwaZoneService", &function_6cc20647);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zmMargwaPushService", &function_fa29651d);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zmMargwaOctobombService", &function_d59056ec);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zmMargwaVortexService", &function_6312be59);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zmMargwaShouldSmashAttack", &function_cbdc3798);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zmMargwaShouldSwipeAttack", &function_ec97fb1e);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zmMargwaShouldOctobombAttack", &function_f0e8cb2d);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zmMargwaShouldMove", &function_1c88d468);
    behaviortreenetworkutility::registerbehaviortreeaction("zmMargwaSwipeAttackAction", &function_cd380e61, &function_edd2fa77, undefined);
    behaviortreenetworkutility::registerbehaviortreeaction("zmMargwaOctobombAttackAction", &function_9fab0124, &function_c5832338, &function_7b2a3a90);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zmMargwaSmashAttackTerminate", &function_7137a16);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zmMargwaSwipeAttackTerminate", &function_137093c0);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zmMargwaTeleportInTerminate", &function_743b10d2);
}

// Namespace namespace_ca5ef87d
// Params 1, eflags: 0x5 linked
// Checksum 0x30bda08b, Offset: 0xb60
// Size: 0x1f2
function private function_c0fb414e(entity) {
    if (isdefined(entity.ignoreall) && entity.ignoreall) {
        return 0;
    }
    if (isdefined(entity.isteleporting) && entity.isteleporting) {
        return 0;
    }
    if (isdefined(entity.var_24971ab5)) {
        return 0;
    }
    entity zombie_utility::run_ignore_player_handler();
    player = zm_utility::get_closest_valid_player(entity.origin, entity.ignore_player);
    entity.favoriteenemy = player;
    if (!isdefined(player) || zm_behavior::zombieshouldmoveawaycondition(entity)) {
        zone = zm_utility::get_current_zone();
        if (isdefined(zone)) {
            wait_locations = level.zones[zone].a_loc_types["wait_location"];
            if (isdefined(wait_locations) && wait_locations.size > 0) {
                return entity namespace_c96301ee::function_30c7c3d3(wait_locations[0].origin, 64, 30);
            }
        }
        entity setgoal(entity.origin);
        return 0;
    }
    return entity namespace_c96301ee::function_30c7c3d3(entity.favoriteenemy.origin, 64, 30);
}

// Namespace namespace_ca5ef87d
// Params 1, eflags: 0x5 linked
// Checksum 0xba288ad3, Offset: 0xd60
// Size: 0x2e4
function private function_5d11b2dc(entity) {
    if (isdefined(entity.favoriteenemy)) {
        if (isdefined(entity.favoriteenemy.var_65f06b5) && entity.favoriteenemy.var_65f06b5) {
            var_d3443466 = [[ level.var_292a0ac9 ]]->function_3e62f527();
            if (isdefined(entity.var_e0d198e4) && entity.var_e0d198e4 && !(isdefined(var_d3443466) && var_d3443466)) {
                return false;
            }
        }
    }
    if (!(isdefined(entity.var_3993b370) && entity.var_3993b370) && !(isdefined(entity.isteleporting) && entity.isteleporting) && isdefined(entity.favoriteenemy)) {
        var_1dd5ad4d = 0;
        dist_sq = distancesquared(self.favoriteenemy.origin, entity.origin);
        var_9c921a96 = 2250000;
        /#
            var_7a419cfb = getdvarint("zm_aat_turned") * 12;
            var_9c921a96 = var_7a419cfb * var_7a419cfb;
        #/
        if (dist_sq > var_9c921a96) {
            if (isdefined(entity.var_24971ab5)) {
                var_1dd5ad4d = 0;
            } else {
                var_1dd5ad4d = 1;
            }
        } else if (isdefined(level.var_785a0d1e)) {
            if (entity [[ level.var_785a0d1e ]]()) {
                var_1dd5ad4d = 1;
            }
        }
        if (var_1dd5ad4d) {
            if (isdefined(self.favoriteenemy.zone_name)) {
                wait_locations = level.zones[self.favoriteenemy.zone_name].a_loc_types["wait_location"];
                if (isdefined(wait_locations) && wait_locations.size > 0) {
                    wait_locations = array::randomize(wait_locations);
                    entity.var_3993b370 = 1;
                    entity.var_16410986 = wait_locations[0].origin;
                    return true;
                }
            }
        }
    }
    return false;
}

// Namespace namespace_ca5ef87d
// Params 1, eflags: 0x5 linked
// Checksum 0x15548d70, Offset: 0x1050
// Size: 0xac
function private function_6cc20647(entity) {
    if (isdefined(entity.isteleporting) && entity.isteleporting) {
        return false;
    }
    if (!isdefined(entity.zone_name)) {
        entity.zone_name = zm_utility::get_current_zone();
    } else {
        entity.previous_zone_name = entity.zone_name;
        entity.zone_name = zm_utility::get_current_zone();
    }
    return true;
}

// Namespace namespace_ca5ef87d
// Params 1, eflags: 0x5 linked
// Checksum 0xbd91e702, Offset: 0x1108
// Size: 0x226
function private function_fa29651d(entity) {
    if (entity.zombie_move_speed == "walk") {
        return 0;
    }
    zombies = zombie_utility::get_round_enemy_array();
    foreach (zombie in zombies) {
        distsq = distancesquared(entity.origin, zombie.origin);
        if (distsq < 2304) {
            zombie.pushed = 1;
            var_16ce8ab3 = self.origin - zombie.origin;
            var_e1fcfc7c = vectornormalize((var_16ce8ab3[0], var_16ce8ab3[1], 0));
            zombie_right = anglestoright(zombie.angles);
            zombie_right_2d = vectornormalize((zombie_right[0], zombie_right[1], 0));
            dot = vectordot(var_e1fcfc7c, zombie_right_2d);
            if (dot > 0) {
                zombie.push_direction = "left";
                continue;
            }
            zombie.push_direction = "right";
        }
    }
}

// Namespace namespace_ca5ef87d
// Params 1, eflags: 0x5 linked
// Checksum 0x2ba1c7bc, Offset: 0x1338
// Size: 0x15a
function private function_d59056ec(entity) {
    if (isdefined(entity.var_24971ab5)) {
        entity setgoal(entity.var_24971ab5.origin);
        return true;
    }
    if (isdefined(level.var_9baa9723)) {
        foreach (var_15c31508 in level.var_9baa9723) {
            if (isdefined(var_15c31508)) {
                dist_sq = distancesquared(var_15c31508.origin, self.origin);
                if (dist_sq < 360000) {
                    entity.var_24971ab5 = var_15c31508;
                    entity setgoal(var_15c31508.origin);
                    return true;
                }
            }
        }
    }
    return false;
}

// Namespace namespace_ca5ef87d
// Params 1, eflags: 0x5 linked
// Checksum 0xa0955baa, Offset: 0x14a0
// Size: 0x9e
function private function_604404(entity) {
    if (isdefined(self.react)) {
        foreach (react in self.react) {
            if (react == entity) {
                return true;
            }
        }
    }
    return false;
}

// Namespace namespace_ca5ef87d
// Params 1, eflags: 0x5 linked
// Checksum 0x64ec76bc, Offset: 0x1548
// Size: 0x3a
function private function_e92d3bb1(entity) {
    if (!isdefined(self.react)) {
        self.react = [];
    }
    self.react[self.react.size] = entity;
}

// Namespace namespace_ca5ef87d
// Params 1, eflags: 0x5 linked
// Checksum 0x21401142, Offset: 0x1590
// Size: 0x1ba
function private function_6312be59(entity) {
    if (!(isdefined(entity.var_894f701d) && entity.var_894f701d)) {
        return false;
    }
    if (isdefined(level.vortex_manager) && isdefined(level.vortex_manager.a_active_vorticies)) {
        foreach (vortex in level.vortex_manager.a_active_vorticies) {
            if (!vortex function_604404(entity)) {
                dist_sq = distancesquared(vortex.origin, self.origin);
                if (dist_sq < 9216) {
                    entity.var_843f1731 = 1;
                    if (isdefined(vortex.weapon) && namespace_42517170::function_9b7ac6a9(vortex.weapon)) {
                        blackboard::setblackboardattribute(entity, "_zombie_damageweapon_type", "packed");
                    }
                    vortex function_e92d3bb1(entity);
                    return true;
                }
            }
        }
    }
    return false;
}

// Namespace namespace_ca5ef87d
// Params 1, eflags: 0x5 linked
// Checksum 0xeec30b91, Offset: 0x1758
// Size: 0x6a
function private function_cbdc3798(entity) {
    if (isdefined(entity.var_24971ab5)) {
        return 0;
    }
    if (!isdefined(entity.var_cef86da1) || entity.var_cef86da1 != 1) {
        return 0;
    }
    return namespace_6c6fd2b0::margwashouldsmashattack(entity);
}

// Namespace namespace_ca5ef87d
// Params 1, eflags: 0x5 linked
// Checksum 0xff4528f5, Offset: 0x17d0
// Size: 0x6a
function private function_ec97fb1e(entity) {
    if (isdefined(entity.var_24971ab5)) {
        return 0;
    }
    if (!isdefined(entity.var_cef86da1) || entity.var_cef86da1 != 2) {
        return 0;
    }
    return namespace_6c6fd2b0::margwashouldswipeattack(entity);
}

// Namespace namespace_ca5ef87d
// Params 1, eflags: 0x5 linked
// Checksum 0xe9d4295a, Offset: 0x1848
// Size: 0xbe
function private function_f0e8cb2d(entity) {
    if (!isdefined(entity.var_24971ab5)) {
        return false;
    }
    if (distancesquared(entity.origin, entity.var_24971ab5.origin) > 16384) {
        return false;
    }
    yaw = abs(zombie_utility::getyawtospot(entity.var_24971ab5.origin));
    if (yaw > 45) {
        return false;
    }
    return true;
}

// Namespace namespace_ca5ef87d
// Params 1, eflags: 0x5 linked
// Checksum 0x40abb118, Offset: 0x1910
// Size: 0xc6
function private function_1c88d468(entity) {
    if (isdefined(entity.var_3993b370) && entity.var_3993b370) {
        return false;
    }
    if (isdefined(entity.var_24971ab5)) {
        if (function_f0e8cb2d(entity)) {
            return false;
        }
    } else {
        if (function_ec97fb1e(entity)) {
            return false;
        }
        if (function_cbdc3798(entity)) {
            return false;
        }
    }
    if (entity haspath()) {
        return true;
    }
    return false;
}

// Namespace namespace_ca5ef87d
// Params 2, eflags: 0x5 linked
// Checksum 0x7d85b2ad, Offset: 0x19e0
// Size: 0x70
function private function_9fab0124(entity, asmstatename) {
    animationstatenetworkutility::requeststate(entity, asmstatename);
    if (!isdefined(entity.var_41294bba)) {
        entity.var_41294bba = gettime() + randomintrange(3000, 4000);
    }
    return 5;
}

// Namespace namespace_ca5ef87d
// Params 2, eflags: 0x5 linked
// Checksum 0xc0e5f83c, Offset: 0x1a58
// Size: 0x5e
function private function_c5832338(entity, asmstatename) {
    if (!isdefined(entity.var_24971ab5)) {
        return 4;
    }
    if (isdefined(entity.var_41294bba) && gettime() > entity.var_41294bba) {
        return 4;
    }
    return 5;
}

// Namespace namespace_ca5ef87d
// Params 2, eflags: 0x5 linked
// Checksum 0xc7367e43, Offset: 0x1ac0
// Size: 0x56
function private function_7b2a3a90(entity, asmstatename) {
    if (isdefined(entity.var_24971ab5)) {
        entity.var_24971ab5 detonate();
    }
    entity.var_41294bba = undefined;
    return 4;
}

// Namespace namespace_ca5ef87d
// Params 2, eflags: 0x5 linked
// Checksum 0xe77b1353, Offset: 0x1b20
// Size: 0x100
function private function_cd380e61(entity, asmstatename) {
    animationstatenetworkutility::requeststate(entity, asmstatename);
    if (!isdefined(entity.var_5ed154c5)) {
        var_6efece41 = entity astsearch(istring(asmstatename));
        var_a6752387 = animationstatenetworkutility::searchanimationmap(entity, var_6efece41["animation"]);
        var_9535398c = getanimlength(var_a6752387) * 1000;
        entity.var_5ed154c5 = gettime() + var_9535398c;
    }
    namespace_6c6fd2b0::margwaswipeattackstart(entity);
    return 5;
}

// Namespace namespace_ca5ef87d
// Params 2, eflags: 0x5 linked
// Checksum 0x615d79d9, Offset: 0x1c28
// Size: 0x46
function private function_edd2fa77(entity, asmstatename) {
    if (isdefined(entity.var_5ed154c5) && gettime() > entity.var_5ed154c5) {
        return 4;
    }
    return 5;
}

// Namespace namespace_ca5ef87d
// Params 1, eflags: 0x5 linked
// Checksum 0x2771dc5e, Offset: 0x1c78
// Size: 0x4c
function private function_7137a16(entity) {
    entity.var_5ed154c5 = undefined;
    entity function_941cbfc5();
    namespace_6c6fd2b0::margwasmashattackterminate(entity);
}

// Namespace namespace_ca5ef87d
// Params 1, eflags: 0x5 linked
// Checksum 0x4e4deeec, Offset: 0x1cd0
// Size: 0x34
function private function_137093c0(entity) {
    entity.var_5ed154c5 = undefined;
    entity function_941cbfc5();
}

// Namespace namespace_ca5ef87d
// Params 1, eflags: 0x5 linked
// Checksum 0x9e26feb2, Offset: 0x1d10
// Size: 0x60
function private function_743b10d2(entity) {
    namespace_6c6fd2b0::function_d6861357(entity);
    entity.previous_zone_name = entity.zone_name;
    entity.zone_name = zm_utility::get_current_zone();
}

// Namespace namespace_ca5ef87d
// Params 0, eflags: 0x4
// Checksum 0x72678812, Offset: 0x1d78
// Size: 0x4c
function private function_271a21d6() {
    self endon(#"death");
    entity.waiting = 1;
    util::wait_network_frame();
    entity.waiting = 0;
}

// Namespace namespace_ca5ef87d
// Params 0, eflags: 0x5 linked
// Checksum 0x1e890827, Offset: 0x1dd0
// Size: 0xfc
function private function_17627e34() {
    self.var_bad584d0 = &function_1f53b1a2;
    self.var_b4036965 = &function_4cf696ce;
    self.var_16ec9b37 = &function_a89905c6;
    self.chop_actor_cb = &function_89e37c9b;
    self.var_a3b60c68 = &function_dbd9ba44;
    self.var_de36fc8 = &function_2aa0209c;
    self.var_d3a99070 = &margwa_smash_attack;
    self.lightning_chain_immune = 1;
    self.ignore_game_over_death = 1;
    self.should_turn = 1;
    self.var_25094731 = 1;
    self.sword_kill_power = 5;
    self function_941cbfc5();
}

// Namespace namespace_ca5ef87d
// Params 2, eflags: 0x5 linked
// Checksum 0x7d5b50ee, Offset: 0x1ed8
// Size: 0x224
function private function_1f53b1a2(var_9c967ca3, attacker) {
    if (isplayer(attacker) && !(isdefined(self.deathpoints_already_given) && self.deathpoints_already_given) && !(isdefined(level.var_1f6ca9c8) && level.var_1f6ca9c8)) {
        attacker zm_score::player_add_points("bonus_points_powerup", 500);
    }
    right = anglestoright(self.angles);
    spawn_pos = self.origin + anglestoright(self.angles) + (0, 0, 128);
    var_df9f2e65 = self.origin - anglestoright(self.angles) + (0, 0, 128);
    loc = spawnstruct();
    loc.origin = spawn_pos;
    loc.angles = self.angles;
    self function_181c5967();
    var_d6f3a912 = undefined;
    if (isdefined(level.var_39c0c115)) {
        var_d6f3a912 = level.var_39c0c115;
    }
    namespace_b1ca30af::function_8aeb3564(1, loc, 32, 32, 1, 0, 0, var_d6f3a912);
    if (isdefined(self.var_26f9f957)) {
        self thread [[ self.var_26f9f957 ]](var_9c967ca3, attacker);
    }
    if (isdefined(level.hero_power_update)) {
        [[ level.hero_power_update ]](attacker, self);
    }
    loc struct::delete();
}

// Namespace namespace_ca5ef87d
// Params 0, eflags: 0x5 linked
// Checksum 0xadbdd166, Offset: 0x2108
// Size: 0x174
function private function_4cf696ce() {
    var_f1aa36cd = self.origin + vectorscale(anglestoforward(self.angles), 32) + (0, 0, 16);
    if (isdefined(var_f1aa36cd) && !(isdefined(self.no_powerups) && self.no_powerups)) {
        var_3bd46762 = [];
        foreach (powerup in level.zombie_powerup_array) {
            if (powerup == "carpenter") {
                continue;
            }
            if (![[ level.zombie_powerups[powerup].func_should_drop_with_regular_powerups ]]()) {
                continue;
            }
            var_3bd46762[var_3bd46762.size] = powerup;
        }
        var_3dc91cb3 = array::random(var_3bd46762);
        level thread zm_powerups::specific_powerup_drop(var_3dc91cb3, var_f1aa36cd);
    }
}

// Namespace namespace_ca5ef87d
// Params 0, eflags: 0x5 linked
// Checksum 0xee1c770f, Offset: 0x2288
// Size: 0xea
function private function_181c5967() {
    players = getplayers();
    foreach (player in players) {
        distsq = distancesquared(self.origin, player.origin);
        if (distsq < 16384) {
            player clientfield::increment_to_player("margwa_head_explosion");
        }
    }
}

// Namespace namespace_ca5ef87d
// Params 1, eflags: 0x1 linked
// Checksum 0x6e188fb3, Offset: 0x2380
// Size: 0x224
function function_8a0708c2(s_location) {
    if (isdefined(level.var_b398aafa[0])) {
        level.var_b398aafa[0].script_forcespawn = 1;
        ai = zombie_utility::spawn_zombie(level.var_b398aafa[0], "margwa", s_location);
        ai disableaimassist();
        ai.actor_damage_func = &namespace_c96301ee::function_b59ae4e9;
        ai.candamage = 0;
        ai.targetname = "margwa";
        ai.holdfire = 1;
        e_player = zm_utility::get_closest_player(s_location.origin);
        v_dir = e_player.origin - s_location.origin;
        v_dir = vectornormalize(v_dir);
        v_angles = vectortoangles(v_dir);
        ai forceteleport(s_location.origin, v_angles);
        ai function_551e32b4();
        if (isdefined(level.var_7cef68dc)) {
            ai thread function_8d578a58();
        }
        ai.var_833cfbae = 1;
        /#
            ai.ignore_devgui_death = 1;
            ai thread function_618bf323();
        #/
        ai thread function_3d56f587();
        return ai;
    }
    return undefined;
}

// Namespace namespace_ca5ef87d
// Params 0, eflags: 0x1 linked
// Checksum 0xdddfa2ac, Offset: 0x25b0
// Size: 0x150
function function_618bf323() {
    self endon(#"death");
    /#
        while (true) {
            if (isdefined(self.var_9e2d6dc4) && self.var_9e2d6dc4) {
                if (isdefined(self.head)) {
                    foreach (head in self.head) {
                        if (head.health > 0) {
                            var_98ed8cd8 = self gettagorigin(head.tag);
                            print3d(var_98ed8cd8 + (0, 0, 15), head.health, (0, 0.8, 0.6), 3);
                        }
                    }
                }
            }
            wait(0.05);
        }
    #/
}

// Namespace namespace_ca5ef87d
// Params 0, eflags: 0x5 linked
// Checksum 0x9b8717e7, Offset: 0x2708
// Size: 0x6c
function private function_3d56f587() {
    util::wait_network_frame();
    self clientfield::increment("margwa_fx_spawn");
    wait(3);
    self function_26c35525();
    self.candamage = 1;
    self.var_c7ae07c2 = 1;
}

// Namespace namespace_ca5ef87d
// Params 0, eflags: 0x5 linked
// Checksum 0xf732d2ab, Offset: 0x2780
// Size: 0x5c
function private function_551e32b4() {
    self.isfrozen = 1;
    self ghost();
    self notsolid();
    self pathmode("dont move");
}

// Namespace namespace_ca5ef87d
// Params 0, eflags: 0x5 linked
// Checksum 0xa6493a8f, Offset: 0x27e8
// Size: 0x5c
function private function_26c35525() {
    self.isfrozen = 0;
    self show();
    self solid();
    self pathmode("move allowed");
}

// Namespace namespace_ca5ef87d
// Params 0, eflags: 0x5 linked
// Checksum 0xe6ab496d, Offset: 0x2850
// Size: 0x124
function private function_8d578a58() {
    attacker, mod, weapon = self waittill(#"death");
    foreach (player in level.players) {
        if (player.am_i_valid && !(isdefined(level.var_1f6ca9c8) && level.var_1f6ca9c8) && !(isdefined(self.var_2d5d7413) && self.var_2d5d7413)) {
            scoreevents::processscoreevent("kill_margwa", player, undefined, undefined);
        }
    }
    level notify(#"hash_1a2d33d7");
    [[ level.var_7cef68dc ]]();
}

// Namespace namespace_ca5ef87d
// Params 3, eflags: 0x5 linked
// Checksum 0x54d0cbf8, Offset: 0x2980
// Size: 0x394
function private function_89e37c9b(entity, inflictor, weapon) {
    if (!(isdefined(entity.candamage) && entity.candamage)) {
        return false;
    }
    var_ddc770da = [];
    if (isdefined(entity.head)) {
        foreach (head in entity.head) {
            if (head.health > 0 && head.candamage) {
                var_ddc770da[var_ddc770da.size] = head;
            }
        }
    }
    if (var_ddc770da.size > 0) {
        view_pos = self getweaponmuzzlepoint();
        forward_view_angles = self getweaponforwarddir();
        var_d8748e76 = undefined;
        foreach (head in var_ddc770da) {
            head_pos = entity gettagorigin(head.tag);
            var_b01d89e6 = distancesquared(head_pos, view_pos);
            var_ca049230 = vectornormalize(head_pos - view_pos);
            if (!isdefined(var_d8748e76)) {
                var_d8748e76 = head;
                var_e4facdff = vectordot(forward_view_angles, var_ca049230);
                continue;
            }
            dot = vectordot(forward_view_angles, var_ca049230);
            if (dot > var_e4facdff) {
                var_e4facdff = dot;
                var_d8748e76 = head;
            }
        }
        if (isdefined(var_d8748e76)) {
            var_d8748e76.health -= 1750;
            entity clientfield::increment(var_d8748e76.var_92dc0464);
            if (var_d8748e76.health <= 0) {
                if (entity namespace_c96301ee::function_a614f89c(var_d8748e76.model, self)) {
                    entity kill(self.origin, undefined, undefined, weapon);
                    return true;
                }
            }
        }
    }
    return false;
}

// Namespace namespace_ca5ef87d
// Params 2, eflags: 0x5 linked
// Checksum 0xaa7ca0d3, Offset: 0x2d20
// Size: 0x4c
function private function_dbd9ba44(entity, weapon) {
    if (isdefined(entity.var_894f701d) && entity.var_894f701d) {
        entity.var_9e59b56e = 1;
    }
}

// Namespace namespace_ca5ef87d
// Params 0, eflags: 0x4
// Checksum 0xf7d7753a, Offset: 0x2d78
// Size: 0x28
function private function_aea7f2f4() {
    if (isdefined(self.var_894f701d) && self.var_894f701d) {
        self.var_843f1731 = 1;
    }
}

// Namespace namespace_ca5ef87d
// Params 1, eflags: 0x5 linked
// Checksum 0x4d91d47, Offset: 0x2da8
// Size: 0xdc
function private function_2aa0209c(trap) {
    if (isdefined(self.var_3993b370) && (isdefined(self.isteleporting) && self.isteleporting || self.var_3993b370)) {
        return;
    }
    self.var_3993b370 = 1;
    pos = self.origin + vectorscale(anglestoforward(self.angles), -56);
    navmesh_pos = getclosestpointonnavmesh(pos, 64, 30);
    self.var_16410986 = navmesh_pos;
    /#
        recordline(self.origin, self.var_16410986);
    #/
}

// Namespace namespace_ca5ef87d
// Params 0, eflags: 0x5 linked
// Checksum 0x10002f0f, Offset: 0x2e90
// Size: 0x12a
function private margwa_smash_attack() {
    zombies = zombie_utility::get_round_enemy_array();
    foreach (zombie in zombies) {
        var_c06eca13 = self.origin + vectorscale(anglestoforward(self.angles), 60);
        distsq = distancesquared(var_c06eca13, zombie.origin);
        if (distsq < 20736) {
            zombie.knockdown = 1;
            self function_f1358c65(zombie);
        }
    }
}

// Namespace namespace_ca5ef87d
// Params 0, eflags: 0x5 linked
// Checksum 0x2915fdf4, Offset: 0x2fc8
// Size: 0x54
function private function_941cbfc5() {
    r = randomintrange(0, 100);
    if (r < 40) {
        self.var_cef86da1 = 2;
        return;
    }
    self.var_cef86da1 = 1;
}

// Namespace namespace_ca5ef87d
// Params 1, eflags: 0x5 linked
// Checksum 0x90b23d2f, Offset: 0x3028
// Size: 0x27c
function private function_f1358c65(zombie) {
    var_16ce8ab3 = self.origin - zombie.origin;
    var_e1fcfc7c = vectornormalize((var_16ce8ab3[0], var_16ce8ab3[1], 0));
    zombie_forward = anglestoforward(zombie.angles);
    zombie_forward_2d = vectornormalize((zombie_forward[0], zombie_forward[1], 0));
    zombie_right = anglestoright(zombie.angles);
    zombie_right_2d = vectornormalize((zombie_right[0], zombie_right[1], 0));
    dot = vectordot(var_e1fcfc7c, zombie_forward_2d);
    if (dot >= 0.5) {
        zombie.knockdown_direction = "front";
        zombie.getup_direction = "getup_back";
        return;
    }
    if (dot < 0.5 && dot > -0.5) {
        dot = vectordot(var_e1fcfc7c, zombie_right_2d);
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

/#

    // Namespace namespace_ca5ef87d
    // Params 0, eflags: 0x5 linked
    // Checksum 0x64709624, Offset: 0x32b0
    // Size: 0x44
    function private function_cdd8baf7() {
        level flagsys::wait_till("zm_aat_turned");
        zm_devgui::add_custom_devgui_callback(&function_a2da506b);
    }

    // Namespace namespace_ca5ef87d
    // Params 1, eflags: 0x5 linked
    // Checksum 0xac09a861, Offset: 0x3300
    // Size: 0x1f6
    function private function_a2da506b(cmd) {
        players = getplayers();
        var_2c8bf5cd = getentarray("zm_aat_turned", "zm_aat_turned");
        margwa = arraygetclosest(getplayers()[0].origin, var_2c8bf5cd);
        switch (cmd) {
        case 8:
            var_2dcff864 = arraygetclosest(players[0].origin, level.var_95810297);
            margwa = function_8a0708c2(var_2dcff864);
            break;
        case 8:
            if (isdefined(margwa)) {
                margwa kill();
            }
            break;
        case 8:
            if (isdefined(margwa)) {
                if (!isdefined(margwa.var_c5dc6229)) {
                    margwa.var_c5dc6229 = 1;
                } else {
                    margwa.var_c5dc6229 = !margwa.var_c5dc6229;
                }
            }
            break;
        case 8:
            if (isdefined(margwa)) {
                if (!isdefined(margwa.var_9e2d6dc4)) {
                    margwa.var_9e2d6dc4 = 1;
                } else {
                    margwa.var_9e2d6dc4 = !margwa.var_9e2d6dc4;
                }
            }
            break;
        }
    }

#/

// Namespace namespace_ca5ef87d
// Params 0, eflags: 0x5 linked
// Checksum 0x63ede08f, Offset: 0x3500
// Size: 0xd6
function private function_a89905c6() {
    /#
        rate = 1;
        if (self.zombie_move_speed == "zm_aat_turned") {
            percent = getdvarint("zm_aat_turned");
            rate = float(percent / 100);
        } else if (self.zombie_move_speed == "zm_aat_turned") {
            percent = getdvarint("zm_aat_turned");
            rate = float(percent / 100);
        }
        return rate;
    #/
}

