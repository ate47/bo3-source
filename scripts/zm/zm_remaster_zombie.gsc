#using scripts/zm/_zm_zonemgr;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_devgui;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/zombie;
#using scripts/shared/laststand_shared;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/systems/animation_state_machine_utility;
#using scripts/shared/ai/systems/animation_state_machine_notetracks;
#using scripts/shared/ai/systems/animation_state_machine_mocomp;
#using scripts/shared/util_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#namespace namespace_1d57720d;

// Namespace namespace_1d57720d
// Params 0, eflags: 0x2
// Checksum 0xdebe4e3b, Offset: 0x3f0
// Size: 0x64
function init() {
    initzmbehaviorsandasm();
    setdvar("tu5_zmPathDistanceCheckTolarance", 20);
    setdvar("scr_zm_use_code_enemy_selection", 0);
    level.var_11c66679 = 1;
    level.var_1ace2307 = 2;
}

// Namespace namespace_1d57720d
// Params 0, eflags: 0x4
// Checksum 0x4633db5c, Offset: 0x460
// Size: 0x84
function initzmbehaviorsandasm() {
    animationstatenetwork::registeranimationmocomp("mocomp_teleport_traversal@zombie", &function_5683b5d5, undefined, undefined);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zodShouldMove", &shouldmove);
    spawner::add_archetype_spawn_function("zombie", &function_9fb7c76f);
}

// Namespace namespace_1d57720d
// Params 5, eflags: 0x0
// Checksum 0x4d8b5341, Offset: 0x4f0
// Size: 0x19c
function function_5683b5d5(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity orientmode("face angle", entity.angles[1]);
    entity animmode("normal");
    if (isdefined(entity.traverseendnode)) {
        /#
            print3d(entity.traversestartnode.origin, "<unknown string>", (1, 0, 0), 1, 1, 60);
            print3d(entity.traverseendnode.origin, "<unknown string>", (0, 1, 0), 1, 1, 60);
            line(entity.traversestartnode.origin, entity.traverseendnode.origin, (0, 1, 0), 1, 0, 60);
        #/
        entity forceteleport(entity.traverseendnode.origin, entity.traverseendnode.angles, 0);
    }
}

// Namespace namespace_1d57720d
// Params 1, eflags: 0x0
// Checksum 0x5c92550, Offset: 0x698
// Size: 0x18a
function shouldmove(entity) {
    if (isdefined(entity.var_128cd975) && entity.var_128cd975 && !(isdefined(entity.tesla_death) && entity.tesla_death)) {
        return false;
    }
    if (isdefined(entity.pushed) && entity.pushed) {
        return false;
    }
    if (isdefined(entity.knockdown) && entity.knockdown) {
        return false;
    }
    if (isdefined(entity.grapple_is_fatal) && entity.grapple_is_fatal) {
        return false;
    }
    if (level.wait_and_revive) {
        if (!(isdefined(entity.var_1e3fb1c) && entity.var_1e3fb1c)) {
            return false;
        }
    }
    if (isdefined(entity.stumble)) {
        return false;
    }
    if (zombiebehavior::zombieshouldmeleecondition(entity)) {
        return false;
    }
    if (entity haspath()) {
        return true;
    }
    if (isdefined(entity.keep_moving) && entity.keep_moving) {
        return true;
    }
    return false;
}

// Namespace namespace_1d57720d
// Params 0, eflags: 0x4
// Checksum 0x2179838e, Offset: 0x830
// Size: 0x1c
function function_9fb7c76f() {
    self.cant_move_cb = &function_f05a4eb4;
}

// Namespace namespace_1d57720d
// Params 0, eflags: 0x4
// Checksum 0xe9dc0e9d, Offset: 0x858
// Size: 0x2c
function function_f05a4eb4() {
    self function_1762804b(0);
    self.enablepushtime = gettime() + 1000;
}

// Namespace namespace_1d57720d
// Params 1, eflags: 0x4
// Checksum 0x82cba5f9, Offset: 0x890
// Size: 0xfa
function function_9b05f3fc(players) {
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

// Namespace namespace_1d57720d
// Params 2, eflags: 0x0
// Checksum 0x21adc3cf, Offset: 0x998
// Size: 0x27a
function function_3ff94b60(origin, players) {
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
    if (isdefined(self.v_zombie_custom_goal_pos)) {
        return self.last_closest_player;
    }
    if (!isdefined(self.need_closest_player)) {
        self.need_closest_player = 1;
    }
    if (isdefined(level.last_closest_time) && level.last_closest_time >= level.time) {
        self function_9b05f3fc(players);
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
    self function_9b05f3fc(players);
    return self.last_closest_player;
}

// Namespace namespace_1d57720d
// Params 0, eflags: 0x0
// Checksum 0x3d6e8425, Offset: 0xc20
// Size: 0x18c
function function_72e6c1d6() {
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

