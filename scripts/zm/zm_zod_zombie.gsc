#using scripts/zm/zm_zod_vo;
#using scripts/zm/zm_zod_portals;
#using scripts/zm/zm_zod;
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

#namespace namespace_99cd1d55;

// Namespace namespace_99cd1d55
// Params 0, eflags: 0x2
// Checksum 0x706b7615, Offset: 0x358
// Size: 0xac
function init() {
    function_3606a81c();
    level.zombie_init_done = &function_e4da8c4d;
    setdvar("scr_zm_use_code_enemy_selection", 0);
    setdvar("tu5_zmPathDistanceCheckTolarance", 20);
    level.closest_player_override = &function_e33b6e60;
    level thread function_72e6c1d6();
    level.var_11c66679 = 1;
    level.var_1ace2307 = 2;
}

// Namespace namespace_99cd1d55
// Params 0, eflags: 0x5 linked
// Checksum 0xa71748a2, Offset: 0x410
// Size: 0x5c
function function_3606a81c() {
    animationstatenetwork::registeranimationmocomp("mocomp_teleport_traversal@zombie", &function_5683b5d5, undefined, undefined);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zodShouldMove", &function_d0ef2cea);
}

// Namespace namespace_99cd1d55
// Params 5, eflags: 0x1 linked
// Checksum 0x40247a63, Offset: 0x478
// Size: 0x104
function function_5683b5d5(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity.var_947f1a5b = 1;
    entity orientmode("face angle", entity.angles[1]);
    entity animmode("normal");
    if (isdefined(entity.traversestartnode)) {
        portal_trig = entity.traversestartnode.portal_trig;
        level clientfield::increment("pulse_" + portal_trig.script_noteworthy);
        portal_trig thread namespace_8e2647d0::function_eb1242c8(entity);
    }
}

// Namespace namespace_99cd1d55
// Params 1, eflags: 0x1 linked
// Checksum 0xc0a8f5b0, Offset: 0x588
// Size: 0x192
function function_d0ef2cea(entity) {
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
        return false;
    }
    if (isdefined(entity.stumble)) {
        return false;
    }
    if (zombiebehavior::zombieshouldmeleecondition(entity)) {
        return false;
    }
    if (isdefined(entity.interdimensional_gun_kill) && !isdefined(entity.killby_interdimensional_gun_hole)) {
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

// Namespace namespace_99cd1d55
// Params 0, eflags: 0x1 linked
// Checksum 0xcfab10c5, Offset: 0x728
// Size: 0x1c
function function_e4da8c4d() {
    self function_1762804b(0);
}

// Namespace namespace_99cd1d55
// Params 1, eflags: 0x5 linked
// Checksum 0x47ab5626, Offset: 0x750
// Size: 0xfa
function function_8e555efc(players) {
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

// Namespace namespace_99cd1d55
// Params 2, eflags: 0x5 linked
// Checksum 0x8502ecf4, Offset: 0x858
// Size: 0x282
function function_e33b6e60(origin, players) {
    if (players.size == 0) {
        return undefined;
    }
    if (isdefined(self.zombie_poi)) {
        return undefined;
    }
    if (players.size == 1) {
        self.last_closest_player = players[0];
        self function_8e555efc(players);
        return self.last_closest_player;
    }
    if (!isdefined(self.last_closest_player)) {
        self.last_closest_player = players[0];
    }
    if (!isdefined(self.need_closest_player)) {
        self.need_closest_player = 1;
    }
    if (isdefined(level.last_closest_time) && level.last_closest_time >= level.time) {
        self function_8e555efc(players);
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
    self function_8e555efc(players);
    return self.last_closest_player;
}

// Namespace namespace_99cd1d55
// Params 0, eflags: 0x5 linked
// Checksum 0x47f0106f, Offset: 0xae8
// Size: 0x1ec
function function_72e6c1d6() {
    level waittill(#"start_of_round");
    while (true) {
        reset_closest_player = 1;
        zombies = zombie_utility::get_round_enemy_array();
        margwa = getaiarchetypearray("margwa", level.zombie_team);
        if (margwa.size) {
            zombies = arraycombine(zombies, margwa, 0, 0);
        }
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

