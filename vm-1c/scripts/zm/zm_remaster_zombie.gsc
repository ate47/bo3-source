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

#namespace zm_remaster_zombie;

// Namespace zm_remaster_zombie
// Params 0, eflags: 0x2
// Checksum 0xfbf5532b, Offset: 0x3f0
// Size: 0x64
function autoexec init() {
    initzmbehaviorsandasm();
    setdvar("tu5_zmPathDistanceCheckTolarance", 20);
    setdvar("scr_zm_use_code_enemy_selection", 0);
    level.var_11c66679 = 1;
    level.var_1ace2307 = 2;
}

// Namespace zm_remaster_zombie
// Params 0, eflags: 0x5 linked
// Checksum 0xa9ce07cf, Offset: 0x460
// Size: 0x84
function private initzmbehaviorsandasm() {
    animationstatenetwork::registeranimationmocomp("mocomp_teleport_traversal@zombie", &function_5683b5d5, undefined, undefined);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zodShouldMove", &shouldmove);
    spawner::add_archetype_spawn_function("zombie", &function_9fb7c76f);
}

// Namespace zm_remaster_zombie
// Params 5, eflags: 0x1 linked
// Checksum 0xc22b2ffb, Offset: 0x4f0
// Size: 0x19c
function function_5683b5d5(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity orientmode("face angle", entity.angles[1]);
    entity animmode("normal");
    if (isdefined(entity.traverseendnode)) {
        /#
            print3d(entity.traversestartnode.origin, "<dev string:x28>", (1, 0, 0), 1, 1, 60);
            print3d(entity.traverseendnode.origin, "<dev string:x28>", (0, 1, 0), 1, 1, 60);
            line(entity.traversestartnode.origin, entity.traverseendnode.origin, (0, 1, 0), 1, 0, 60);
        #/
        entity forceteleport(entity.traverseendnode.origin, entity.traverseendnode.angles, 0);
    }
}

// Namespace zm_remaster_zombie
// Params 1, eflags: 0x1 linked
// Checksum 0x77b65ed8, Offset: 0x698
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

// Namespace zm_remaster_zombie
// Params 0, eflags: 0x5 linked
// Checksum 0xf1728ea8, Offset: 0x830
// Size: 0x1c
function private function_9fb7c76f() {
    self.cant_move_cb = &function_f05a4eb4;
}

// Namespace zm_remaster_zombie
// Params 0, eflags: 0x5 linked
// Checksum 0x132162ae, Offset: 0x858
// Size: 0x2c
function private function_f05a4eb4() {
    self function_1762804b(0);
    self.enablepushtime = gettime() + 1000;
}

// Namespace zm_remaster_zombie
// Params 1, eflags: 0x5 linked
// Checksum 0xf2ed28b9, Offset: 0x890
// Size: 0xfa
function private function_9b05f3fc(players) {
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

// Namespace zm_remaster_zombie
// Params 2, eflags: 0x0
// Checksum 0xebfe0d9f, Offset: 0x998
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

// Namespace zm_remaster_zombie
// Params 0, eflags: 0x0
// Checksum 0x62a993ec, Offset: 0xc20
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
        wait 0.05;
    }
}

