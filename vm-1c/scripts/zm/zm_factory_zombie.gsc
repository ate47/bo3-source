#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_behavior;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/zombie;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/systems/animation_state_machine_mocomp;
#using scripts/shared/ai/systems/animation_state_machine_notetracks;
#using scripts/shared/ai/systems/animation_state_machine_utility;
#using scripts/shared/util_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_27d8454e;

// Namespace namespace_27d8454e
// Params 0, eflags: 0x2
// Checksum 0x7e13f35d, Offset: 0x300
// Size: 0x8c
function autoexec init() {
    function_46f62f6f();
    level.zombie_init_done = &function_f06eec12;
    setdvar("scr_zm_use_code_enemy_selection", 0);
    level.closest_player_override = &function_1daba8b7;
    level thread function_72e6c1d6();
    level.var_11c66679 = 1;
    level.var_1ace2307 = 2;
}

// Namespace namespace_27d8454e
// Params 0, eflags: 0x5 linked
// Checksum 0x7bfdec8c, Offset: 0x398
// Size: 0x64
function private function_46f62f6f() {
    behaviortreenetworkutility::registerbehaviortreescriptapi("ZmFactoryTraversalService", &function_b1713093);
    animationstatenetwork::registeranimationmocomp("mocomp_idle_special_factory", &function_a9009b71, undefined, &function_3574d810);
}

// Namespace namespace_27d8454e
// Params 1, eflags: 0x1 linked
// Checksum 0xa49e322c, Offset: 0x408
// Size: 0x44
function function_b1713093(entity) {
    if (isdefined(entity.traversestartnode)) {
        entity function_1762804b(0);
        return true;
    }
    return false;
}

// Namespace namespace_27d8454e
// Params 5, eflags: 0x5 linked
// Checksum 0x31de441a, Offset: 0x458
// Size: 0x104
function private function_a9009b71(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    if (isdefined(entity.enemyoverride) && isdefined(entity.enemyoverride[1])) {
        entity orientmode("face direction", entity.enemyoverride[1].origin - entity.origin);
        entity animmode("zonly_physics", 0);
        return;
    }
    entity orientmode("face current");
    entity animmode("zonly_physics", 0);
}

// Namespace namespace_27d8454e
// Params 5, eflags: 0x5 linked
// Checksum 0x1fd3e9e8, Offset: 0x568
// Size: 0x2c
function private function_3574d810(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    
}

// Namespace namespace_27d8454e
// Params 0, eflags: 0x1 linked
// Checksum 0x6c30432e, Offset: 0x5a0
// Size: 0x1c
function function_f06eec12() {
    self function_1762804b(0);
}

// Namespace namespace_27d8454e
// Params 1, eflags: 0x5 linked
// Checksum 0xc6405d0a, Offset: 0x5c8
// Size: 0xfa
function private function_f20cbe8b(players) {
    if (isdefined(self.last_closest_player.am_i_valid) && isdefined(self.last_closest_player) && self.last_closest_player.am_i_valid) {
        return;
    }
    self.need_closest_player = 1;
    foreach (player in players) {
        if (isdefined(player.am_i_valid) && player.am_i_valid) {
            self.last_closest_player = player;
            return;
        }
    }
    self.last_closest_player = undefined;
}

// Namespace namespace_27d8454e
// Params 2, eflags: 0x5 linked
// Checksum 0xe248ceef, Offset: 0x6d0
// Size: 0x262
function private function_1daba8b7(origin, players) {
    if (players.size == 0) {
        return undefined;
    }
    if (isdefined(self.zombie_poi)) {
        return undefined;
    }
    if (players.size == 1) {
        self.last_closest_player = players[0];
        return self.last_closest_player;
    }
    if (!isdefined(self.last_closest_player)) {
        self.last_closest_player = players[0];
    }
    if (!isdefined(self.need_closest_player)) {
        self.need_closest_player = 1;
    }
    if (isdefined(level.last_closest_time) && level.last_closest_time >= level.time) {
        self function_f20cbe8b(players);
        return self.last_closest_player;
    }
    if (isdefined(self.need_closest_player) && self.need_closest_player) {
        level.last_closest_time = level.time;
        self.need_closest_player = 0;
        closest = players[0];
        closest_dist = self zm_utility::approximate_path_dist(closest);
        if (!isdefined(closest_dist)) {
            closest = undefined;
        }
        for (index = 1; index < players.size; index++) {
            dist = self zm_utility::approximate_path_dist(players[index]);
            if (isdefined(dist)) {
                if (isdefined(closest_dist)) {
                    if (dist < closest_dist) {
                        closest = players[index];
                        closest_dist = dist;
                    }
                    continue;
                }
                closest = players[index];
                closest_dist = dist;
            }
        }
        self.last_closest_player = closest;
    }
    if (players.size > 1 && isdefined(closest)) {
        self zm_utility::approximate_path_dist(closest);
    }
    self function_f20cbe8b(players);
    return self.last_closest_player;
}

// Namespace namespace_27d8454e
// Params 0, eflags: 0x5 linked
// Checksum 0xd4e0ad5c, Offset: 0x940
// Size: 0x18c
function private function_72e6c1d6() {
    level waittill(#"start_of_round");
    while (true) {
        reset_closest_player = 1;
        zombies = zombie_utility::get_round_enemy_array();
        foreach (zombie in zombies) {
            if (isdefined(zombie.need_closest_player) && zombie.need_closest_player) {
                reset_closest_player = 0;
                break;
            }
        }
        if (reset_closest_player) {
            foreach (zombie in zombies) {
                if (isdefined(zombie.need_closest_player)) {
                    zombie.need_closest_player = 1;
                }
            }
        }
        wait(0.05);
    }
}

