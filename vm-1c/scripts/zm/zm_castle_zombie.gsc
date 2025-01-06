#using scripts/codescripts/struct;
#using scripts/shared/ai/systems/animation_state_machine_mocomp;
#using scripts/shared/ai/systems/animation_state_machine_notetracks;
#using scripts/shared/ai/systems/animation_state_machine_utility;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai/zombie;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_devgui;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_zonemgr;

#namespace zm_castle_zombie;

// Namespace zm_castle_zombie
// Params 0, eflags: 0x2
// Checksum 0x1dca0df4, Offset: 0x470
// Size: 0x114
function autoexec init() {
    function_83f83141();
    level.var_4fb25bb9 = [];
    level.var_4fb25bb9["walk"] = 4;
    level.var_4fb25bb9["run"] = 4;
    level.var_4fb25bb9["sprint"] = 4;
    level.var_4fb25bb9["crawl"] = 3;
    setdvar("tu5_zmPathDistanceCheckTolarance", 20);
    setdvar("scr_zm_use_code_enemy_selection", 0);
    level.closest_player_override = &castle_closest_player;
    level thread function_72e6c1d6();
    /#
        thread function_e250a9f();
    #/
    level.var_11c66679 = 1;
    level.var_1ace2307 = 2;
}

// Namespace zm_castle_zombie
// Params 0, eflags: 0x4
// Checksum 0xe1c68a03, Offset: 0x590
// Size: 0x84
function private function_83f83141() {
    animationstatenetwork::registeranimationmocomp("mocomp_teleport_traversal@zombie", &function_5683b5d5, undefined, undefined);
    behaviortreenetworkutility::registerbehaviortreescriptapi("shouldMoveLowg", &shouldMoveLowg);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zodShouldMove", &zodShouldMove);
}

// Namespace zm_castle_zombie
// Params 5, eflags: 0x0
// Checksum 0xd127e1e7, Offset: 0x620
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

// Namespace zm_castle_zombie
// Params 1, eflags: 0x0
// Checksum 0x957d1784, Offset: 0x7c8
// Size: 0x18a
function zodShouldMove(entity) {
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

// Namespace zm_castle_zombie
// Params 1, eflags: 0x0
// Checksum 0xcafbeae0, Offset: 0x960
// Size: 0x2e
function shouldMoveLowg(entity) {
    return isdefined(entity.low_gravity) && entity.low_gravity;
}

// Namespace zm_castle_zombie
// Params 1, eflags: 0x0
// Checksum 0xf4992ebb, Offset: 0x998
// Size: 0xbc
function set_gravity(gravity) {
    if (gravity == "low") {
        self.low_gravity = 1;
        if (isdefined(self.missinglegs) && self.missinglegs) {
            self.low_gravity_variant = randomint(level.var_4fb25bb9["crawl"]);
        } else {
            self.low_gravity_variant = randomint(level.var_4fb25bb9[self.zombie_move_speed]);
        }
        return;
    }
    if (gravity == "normal") {
        self.low_gravity = 0;
    }
}

// Namespace zm_castle_zombie
// Params 1, eflags: 0x0
// Checksum 0xb39cf8a6, Offset: 0xa60
// Size: 0x350
function function_7b63bf24(player) {
    var_b9ec9b33 = 0;
    var_ef36a2fe = 0;
    if (self.archetype == "mechz") {
        if (self zm_zonemgr::entity_in_zone("zone_undercroft")) {
            a_players = getplayers();
            var_2ace9ca5 = 0;
            var_949334ad = 0;
            foreach (target in a_players) {
                if (zombie_utility::is_player_valid(target, 1) && target zm_zonemgr::entity_in_zone("zone_undercroft")) {
                    var_949334ad += 1;
                    if (target iswallrunning() || !target isonground()) {
                        var_2ace9ca5 += 1;
                    }
                }
            }
            if (player iswallrunning() || var_2ace9ca5 < var_949334ad && !player isonground()) {
                return false;
            }
        }
        return true;
    }
    if (isdefined(self.zone_name)) {
        if (self.zone_name == "zone_v10_pad" || self.zone_name == "zone_v10_pad_door" || self.zone_name == "zone_v10_pad_exterior") {
            var_b9ec9b33 = 1;
            if (!(isdefined(level.zones["zone_v10_pad_door"].is_spawning_allowed) && level.zones["zone_v10_pad_door"].is_spawning_allowed)) {
                var_2d8a543 = getent("zone_v10_pad", "targetname");
                if (!self istouching(var_2d8a543)) {
                    return false;
                }
            }
        }
    }
    if (isdefined(player.zone_name)) {
        if (player.zone_name == "zone_v10_pad" || player.zone_name == "zone_v10_pad_door" || player.zone_name == "zone_v10_pad_exterior") {
            var_ef36a2fe = 1;
        }
    }
    if (var_b9ec9b33 == var_ef36a2fe) {
        return true;
    }
    return false;
}

// Namespace zm_castle_zombie
// Params 1, eflags: 0x4
// Checksum 0x2520d9a7, Offset: 0xdb8
// Size: 0xee
function private function_3cc0a9c3(players) {
    if (isdefined(self.last_closest_player.am_i_valid) && isdefined(self.last_closest_player) && self.last_closest_player.am_i_valid) {
        return;
    }
    self.need_closest_player = 1;
    foreach (player in players) {
        if (self function_7b63bf24(player)) {
            self.last_closest_player = player;
            return;
        }
    }
    self.last_closest_player = undefined;
}

// Namespace zm_castle_zombie
// Params 1, eflags: 0x4
// Checksum 0x840be87b, Offset: 0xeb0
// Size: 0x94
function private function_ca4f6cd2(player) {
    if (isdefined(player.zone_name)) {
        if (player.zone_name == "zone_v10_pad") {
            dist = distance(player.origin, self.origin);
            return dist;
        }
    }
    dist = self zm_utility::approximate_path_dist(player);
    return dist;
}

// Namespace zm_castle_zombie
// Params 2, eflags: 0x4
// Checksum 0xa64767d2, Offset: 0xf50
// Size: 0x38a
function private castle_closest_player(origin, var_6c55ba74) {
    aiprofile_beginentry("castle_closest_player");
    players = array::filter(var_6c55ba74, 0, &function_4fee0339);
    if (players.size == 0) {
        aiprofile_endentry();
        return undefined;
    }
    if (isdefined(self.zombie_poi)) {
        aiprofile_endentry();
        return undefined;
    }
    if (players.size == 1) {
        if (self function_7b63bf24(players[0])) {
            self.last_closest_player = players[0];
            aiprofile_endentry();
            return self.last_closest_player;
        }
        aiprofile_endentry();
        return undefined;
    }
    if (!isdefined(self.last_closest_player)) {
        self.last_closest_player = players[0];
    }
    if (!isdefined(self.need_closest_player)) {
        self.need_closest_player = 1;
    }
    if (isdefined(level.last_closest_time) && level.last_closest_time >= level.time) {
        self function_3cc0a9c3(players);
        aiprofile_endentry();
        return self.last_closest_player;
    }
    if (isdefined(self.need_closest_player) && self.need_closest_player) {
        level.last_closest_time = level.time;
        self.need_closest_player = 0;
        closest = players[0];
        closest_dist = undefined;
        if (self function_7b63bf24(players[0])) {
            closest_dist = self function_ca4f6cd2(closest);
        }
        if (!isdefined(closest_dist)) {
            closest = undefined;
        }
        for (index = 1; index < players.size; index++) {
            dist = undefined;
            if (self function_7b63bf24(players[index])) {
                dist = self function_ca4f6cd2(players[index]);
            }
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
    self function_3cc0a9c3(players);
    aiprofile_endentry();
    return self.last_closest_player;
}

// Namespace zm_castle_zombie
// Params 1, eflags: 0x4
// Checksum 0x1b27598e, Offset: 0x12e8
// Size: 0xae
function private function_4fee0339(player) {
    if (!isdefined(player) || !isalive(player) || !isplayer(player) || player.sessionstate == "spectator" || player.sessionstate == "intermission" || player laststand::player_is_in_laststand() || player.ignoreme) {
        return false;
    }
    return true;
}

// Namespace zm_castle_zombie
// Params 0, eflags: 0x4
// Checksum 0x7bfe8db3, Offset: 0x13a0
// Size: 0x1ec
function private function_72e6c1d6() {
    level waittill(#"start_of_round");
    while (true) {
        reset_closest_player = 1;
        zombies = zombie_utility::get_round_enemy_array();
        var_6aad1b23 = getaiarchetypearray("mechz", level.zombie_team);
        if (var_6aad1b23.size) {
            zombies = arraycombine(zombies, var_6aad1b23, 0, 0);
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
        wait 0.05;
    }
}

/#

    // Namespace zm_castle_zombie
    // Params 0, eflags: 0x4
    // Checksum 0xf9cf446a, Offset: 0x1598
    // Size: 0x5c
    function private function_e250a9f() {
        level flagsys::wait_till("<dev string:x2a>");
        zm_devgui::add_custom_devgui_callback(&function_e48879e3);
        adddebugcommand("<dev string:x43>");
    }

    // Namespace zm_castle_zombie
    // Params 1, eflags: 0x4
    // Checksum 0xb791ea9d, Offset: 0x1600
    // Size: 0x1de
    function private function_e48879e3(cmd) {
        switch (cmd) {
        case "<dev string:x89>":
            if (!isdefined(level.var_c43a1504)) {
                level.var_c43a1504 = 1;
            } else {
                level.var_c43a1504 = !level.var_c43a1504;
            }
            zombies = getaispeciesarray(level.zombie_team, "<dev string:x95>");
            foreach (zombie in zombies) {
                if (isdefined(level.var_c43a1504) && level.var_c43a1504) {
                    zombie set_gravity("<dev string:x99>");
                    if (zombie ai::has_behavior_attribute("<dev string:x9d>")) {
                        zombie ai::set_behavior_attribute("<dev string:x9d>", "<dev string:x99>");
                    }
                    continue;
                }
                zombie set_gravity("<dev string:xa5>");
                if (zombie ai::has_behavior_attribute("<dev string:x9d>")) {
                    zombie ai::set_behavior_attribute("<dev string:x9d>", "<dev string:xa5>");
                }
            }
            break;
        }
    }

#/
