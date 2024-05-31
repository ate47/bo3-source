#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_puppet;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_pers_upgrades_functions;
#using scripts/zm/_zm_pers_upgrades;
#using scripts/zm/_zm_net;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_blockers;
#using scripts/zm/_zm_behavior_utility;
#using scripts/zm/_zm_behavior;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm;
#using scripts/zm/_util;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai/zombie_shared;
#using scripts/shared/ai/zombie_death;
#using scripts/shared/util_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/demo_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace zm_spawner;

// Namespace zm_spawner
// Params 0, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_c35e6aab
// Checksum 0x68af279, Offset: 0x10b0
// Size: 0x20c
function init() {
    level._contextual_grab_lerp_time = 0.3;
    level.zombie_spawners = getentarray("zombie_spawner", "script_noteworthy");
    level.var_5a487977 = [];
    level.var_22060a89 = [];
    if (isdefined(level.use_multiple_spawns) && level.use_multiple_spawns) {
        level.zombie_spawn = [];
        for (i = 0; i < level.zombie_spawners.size; i++) {
            if (isdefined(level.zombie_spawners[i].script_int)) {
                int = level.zombie_spawners[i].script_int;
                if (!isdefined(level.zombie_spawn[int])) {
                    level.zombie_spawn[int] = [];
                }
                level.zombie_spawn[int][level.zombie_spawn[int].size] = level.zombie_spawners[i];
            }
        }
    }
    if (isdefined(level.ignore_spawner_func)) {
        for (i = 0; i < level.zombie_spawners.size; i++) {
            ignore = [[ level.ignore_spawner_func ]](level.zombie_spawners[i]);
            if (ignore) {
                arrayremovevalue(level.zombie_spawners, level.zombie_spawners[i]);
            }
        }
    }
    if (!isdefined(level.attack_player_thru_boards_range)) {
        level.attack_player_thru_boards_range = 109.8;
    }
    if (isdefined(level._game_module_custom_spawn_init_func)) {
        [[ level._game_module_custom_spawn_init_func ]]();
    }
    /#
        level thread debug_show_exterior_goals();
    #/
}

/#

    // Namespace zm_spawner
    // Params 0, eflags: 0x1 linked
    // namespace_ae969b2b<file_0>::function_fa618012
    // Checksum 0x7f91a350, Offset: 0x12c8
    // Size: 0x468
    function debug_show_exterior_goals() {
        while (true) {
            if (isdefined(level.toggle_show_exterior_goals) && level.toggle_show_exterior_goals) {
                color = (1, 1, 1);
                color_red = (1, 0, 0);
                color_blue = (0, 0, 1);
                foreach (zone in level.zones) {
                    foreach (location in zone.a_loc_types["stand"]) {
                        recordstar(location.origin, color);
                    }
                }
                foreach (zone in level.zones) {
                    foreach (location in zone.a_loc_types["stand"]) {
                        foreach (goal in level.exterior_goals) {
                            if (goal.script_string == location.script_string) {
                                recordline(location.origin, goal.origin, color);
                                goal.has_spawner = 1;
                                break;
                            }
                        }
                    }
                }
                foreach (goal in level.exterior_goals) {
                    if (isdefined(goal.has_spawner) && goal.has_spawner) {
                        recordcircle(goal.origin, 16, color);
                        continue;
                    }
                    if (isdefined(goal.script_string) && goal.script_string == "stand") {
                        recordcircle(goal.origin, 16, color_blue);
                        continue;
                    }
                    recordcircle(goal.origin, 16, color_red);
                }
            }
            wait(0.05);
        }
    }

#/

// Namespace zm_spawner
// Params 12, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_cb45f8b1
// Checksum 0x60fcc9dc, Offset: 0x1738
// Size: 0x1d4
function function_cb45f8b1(player, amount, type, point, weapon, direction_vec, tagname, modelname, partname, dflags, inflictor, chargelevel) {
    team = undefined;
    if (isdefined(self._race_team)) {
        team = self._race_team;
    }
    if (isdefined(player.allow_zombie_to_target_ai) && player.allow_zombie_to_target_ai || !player util::is_ads()) {
        [[ level.var_e88bb559 ]](type, self.damagelocation, point, player, amount, team, weapon, direction_vec, tagname, modelname, partname, dflags, inflictor, chargelevel);
        return false;
    }
    if (!zm_utility::bullet_attack(type)) {
        [[ level.var_e88bb559 ]](type, self.damagelocation, point, player, amount, team, weapon, direction_vec, tagname, modelname, partname, dflags, inflictor, chargelevel);
        return false;
    }
    [[ level.var_6a21f752 ]](type, self.damagelocation, point, player, amount, team, weapon, direction_vec, tagname, modelname, partname, dflags, inflictor, chargelevel);
    return true;
}

// Namespace zm_spawner
// Params 1, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_94b48f88
// Checksum 0x4fc4f28d, Offset: 0x1918
// Size: 0x2e
function function_94b48f88(attacker) {
    if (isplayer(attacker)) {
        return true;
    }
    return false;
}

// Namespace zm_spawner
// Params 0, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_1612a0b8
// Checksum 0xeba0a10c, Offset: 0x1950
// Size: 0x168
function function_1612a0b8() {
    self endon(#"death");
    for (;;) {
        amount, attacker, direction_vec, point, type, tagname, modelname, partname, weapon, dflags, inflictor, chargelevel = self waittill(#"damage");
        if (!isdefined(amount)) {
            continue;
        }
        if (!isalive(self)) {
            return;
        }
        if (!function_94b48f88(attacker) && !(isdefined(attacker.allow_zombie_to_target_ai) && attacker.allow_zombie_to_target_ai)) {
            continue;
        }
        self.has_been_damaged_by_player = 1;
        self function_cb45f8b1(attacker, amount, type, point, weapon, direction_vec, tagname, modelname, partname, dflags, inflictor, chargelevel);
    }
}

// Namespace zm_spawner
// Params 1, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_8c5c2e62
// Checksum 0xf1e01209, Offset: 0x1ac0
// Size: 0xfa
function is_spawner_targeted_by_blocker(ent) {
    if (isdefined(ent.targetname)) {
        targeters = getentarray(ent.targetname, "target");
        for (i = 0; i < targeters.size; i++) {
            if (targeters[i].targetname == "zombie_door" || targeters[i].targetname == "zombie_debris") {
                return true;
            }
            result = is_spawner_targeted_by_blocker(targeters[i]);
            if (result) {
                return true;
            }
        }
    }
    return false;
}

// Namespace zm_spawner
// Params 1, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_f532f99e
// Checksum 0x238c77e2, Offset: 0x1bc8
// Size: 0x3a
function add_custom_zombie_spawn_logic(func) {
    if (!isdefined(level._zombie_custom_spawn_logic)) {
        level._zombie_custom_spawn_logic = [];
    }
    level._zombie_custom_spawn_logic[level._zombie_custom_spawn_logic.size] = func;
}

// Namespace zm_spawner
// Params 1, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_63a51f54
// Checksum 0xffa44670, Offset: 0x1c10
// Size: 0x6ce
function zombie_spawn_init(var_86a233b2) {
    if (!isdefined(var_86a233b2)) {
        var_86a233b2 = 0;
    }
    self.targetname = "zombie";
    self.script_noteworthy = undefined;
    zm_utility::function_20fdac8();
    if (!var_86a233b2) {
        self.animname = "zombie";
    }
    if (isdefined(zm_utility::get_gamemode_var("pre_init_zombie_spawn_func"))) {
        self [[ zm_utility::get_gamemode_var("pre_init_zombie_spawn_func") ]]();
    }
    self thread play_ambient_zombie_vocals();
    self thread zm_audio::zmbaivox_notifyconvert();
    self.zmb_vocals_attack = "zmb_vocals_zombie_attack";
    self.ignoreme = 0;
    self.allowdeath = 1;
    self.force_gib = 1;
    self.is_zombie = 1;
    self allowedstances("stand");
    self.attackercountthreatscale = 0;
    self.currentenemythreatscale = 0;
    self.recentattackerthreatscale = 0;
    self.coverthreatscale = 0;
    self.fovcosine = 0;
    self.fovcosinebusy = 0;
    self.zombie_damaged_by_bar_knockdown = 0;
    self.gibbed = 0;
    self.head_gibbed = 0;
    self setphysparams(15, 0, 72);
    self.goalradius = 32;
    self.disablearrivals = 1;
    self.disableexits = 1;
    self.grenadeawareness = 0;
    self.badplaceawareness = 0;
    self.ignoresuppression = 1;
    self.suppressionthreshold = 1;
    self.nododgemove = 1;
    self.dontshootwhilemoving = 1;
    self.pathenemylookahead = 0;
    self.holdfire = 1;
    self.badplaceawareness = 0;
    self.chatinitialized = 0;
    self.missinglegs = 0;
    if (!isdefined(self.zombie_arms_position)) {
        if (randomint(2) == 0) {
            self.zombie_arms_position = "up";
        } else {
            self.zombie_arms_position = "down";
        }
    }
    if (randomint(100) < 25) {
        self.canstumble = 1;
    }
    self.a.disablepain = 1;
    self zm_utility::disable_react();
    if (isdefined(level.zombie_health)) {
        self.maxhealth = level.zombie_health;
        if (isdefined(level.var_5a487977[self.archetype]) && level.var_5a487977[self.archetype].size > 0) {
            self.health = level.var_5a487977[self.archetype][0];
            arrayremovevalue(level.var_5a487977[self.archetype], level.var_5a487977[self.archetype][0]);
        } else {
            self.health = level.zombie_health;
        }
    } else {
        self.maxhealth = level.zombie_vars["zombie_health_start"];
        self.health = self.maxhealth;
    }
    self.freezegun_damage = 0;
    self setavoidancemask("avoid none");
    self pathmode("dont move");
    level thread zombie_death_event(self);
    self zm_utility::init_zombie_run_cycle();
    self thread zombie_think();
    self thread zombie_utility::zombie_gib_on_damage();
    self thread zombie_damage_failsafe();
    self thread function_1612a0b8();
    if (isdefined(level._zombie_custom_spawn_logic)) {
        if (isarray(level._zombie_custom_spawn_logic)) {
            for (i = 0; i < level._zombie_custom_spawn_logic.size; i++) {
                self thread [[ level._zombie_custom_spawn_logic[i] ]]();
            }
        } else {
            self thread [[ level._zombie_custom_spawn_logic ]]();
        }
    }
    if (!isdefined(self.no_eye_glow) || !self.no_eye_glow) {
        if (!(isdefined(self.is_inert) && self.is_inert)) {
            self thread zombie_utility::delayed_zombie_eye_glow();
        }
    }
    self.deathfunction = &zombie_death_animscript;
    self.flame_damage_time = 0;
    self.meleedamage = 60;
    self.no_powerups = 1;
    self zombie_history("zombie_spawn_init -> Spawned = " + self.origin);
    self.thundergun_knockdown_func = level.basic_zombie_thundergun_knockdown;
    self.tesla_head_gib_func = &zombie_tesla_head_gib;
    self.team = level.zombie_team;
    self.updatesight = 0;
    self.heroweapon_kill_power = 2;
    self.sword_kill_power = 2;
    if (isdefined(level.var_9aca36e2)) {
        self [[ level.var_9aca36e2 ]]();
    }
    if (isdefined(zm_utility::get_gamemode_var("post_init_zombie_spawn_func"))) {
        self [[ zm_utility::get_gamemode_var("post_init_zombie_spawn_func") ]]();
    }
    if (isdefined(level.zombie_init_done)) {
        self [[ level.zombie_init_done ]]();
    }
    self.zombie_init_done = 1;
    self notify(#"zombie_init_done");
}

// Namespace zm_spawner
// Params 0, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_ae9b0147
// Checksum 0x4972c634, Offset: 0x22e8
// Size: 0x1de
function zombie_damage_failsafe() {
    self endon(#"death");
    for (var_370bf1e2 = 0; true; var_370bf1e2 = 0) {
        wait(0.5);
        if (!isdefined(self.enemy) || !isplayer(self.enemy)) {
            continue;
        }
        if (self istouching(self.enemy)) {
            var_f0375013 = self.origin;
            if (!var_370bf1e2) {
                wait(5);
            }
            if (!isdefined(self.enemy) || !isplayer(self.enemy) || self.enemy hasperk("specialty_armorvest")) {
                continue;
            }
            if (self istouching(self.enemy) && !self.enemy laststand::player_is_in_laststand() && isalive(self.enemy)) {
                if (distancesquared(var_f0375013, self.origin) < 3600) {
                    self.enemy dodamage(self.enemy.health + 1000, self.enemy.origin, self, self, "none", "MOD_RIFLE_BULLET");
                    var_370bf1e2 = 1;
                }
            }
            continue;
        }
    }
}

// Namespace zm_spawner
// Params 1, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_6e266f55
// Checksum 0xf413aa98, Offset: 0x24d0
// Size: 0x58
function should_skip_teardown(find_flesh_struct_string) {
    if (isdefined(find_flesh_struct_string) && find_flesh_struct_string == "find_flesh") {
        return true;
    }
    if (isdefined(self.script_string) && self.script_string == "find_flesh") {
        return true;
    }
    return false;
}

// Namespace zm_spawner
// Params 0, eflags: 0x0
// namespace_ae969b2b<file_0>::function_8333c402
// Checksum 0x78776b08, Offset: 0x2530
// Size: 0x3b0
function function_8333c402() {
    node = undefined;
    var_a7630bb3 = [];
    self.entrance_nodes = [];
    if (isdefined(level.var_815f3ea6)) {
        max_dist = level.var_815f3ea6;
    } else {
        max_dist = 500;
    }
    if (!isdefined(self.find_flesh_struct_string) && isdefined(self.target) && self.target != "") {
        desired_origin = zombie_utility::get_desired_origin();
        assert(isdefined(desired_origin), "stand" + self.origin + "stand");
        origin = desired_origin;
        node = arraygetclosest(origin, level.exterior_goals);
        self.entrance_nodes[self.entrance_nodes.size] = node;
        self zombie_history("zombie_think -> #1 entrance (script_forcegoal) origin = " + self.entrance_nodes[0].origin);
    } else if (self should_skip_teardown(self.find_flesh_struct_string)) {
        self zombie_setup_attack_properties();
        if (isdefined(self.target)) {
            var_61cc13fb = getnode(self.target, "targetname");
            if (isdefined(var_61cc13fb)) {
                self setgoalnode(var_61cc13fb);
                self waittill(#"goal");
            }
        }
        if (isdefined(self.start_inert) && self.start_inert) {
            self zombie_complete_emerging_into_playable_area();
            return;
        }
        self thread zombie_entered_playable();
        return;
    } else if (isdefined(self.find_flesh_struct_string)) {
        assert(isdefined(self.find_flesh_struct_string));
        for (i = 0; i < level.exterior_goals.size; i++) {
            if (isdefined(level.exterior_goals[i].script_string) && level.exterior_goals[i].script_string == self.find_flesh_struct_string) {
                node = level.exterior_goals[i];
                break;
            }
        }
        self.entrance_nodes[self.entrance_nodes.size] = node;
        self zombie_history("zombie_think -> #1 entrance origin = " + node.origin);
        self thread zombie_assure_node();
    }
    assert(isdefined(node), "stand");
    level thread zm_utility::draw_line_ent_to_pos(self, node.origin, "goal");
    self.first_node = node;
}

// Namespace zm_spawner
// Params 0, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_a7a6abf6
// Checksum 0xf66f38bf, Offset: 0x28e8
// Size: 0x180
function zombie_think() {
    self endon(#"death");
    assert(!self.isdog);
    self.ai_state = "zombie_think";
    find_flesh_struct_string = undefined;
    if (isdefined(level.zombie_custom_think_logic)) {
        shouldwait = self [[ level.zombie_custom_think_logic ]]();
        if (shouldwait) {
            find_flesh_struct_string = self waittill(#"zombie_custom_think_done");
        }
    } else if (isdefined(self.start_inert) && self.start_inert) {
        find_flesh_struct_string = "find_flesh";
    } else {
        if (isdefined(self.custom_location)) {
            self thread [[ self.custom_location ]]();
        } else {
            self thread do_zombie_spawn();
        }
        find_flesh_struct_string = self waittill(#"risen");
    }
    self.find_flesh_struct_string = find_flesh_struct_string;
    /#
        self.backupnode = self.first_node;
        self thread zm_puppet::wait_for_puppet_pickup();
    #/
    self setgoal(self.origin);
    self pathmode("move allowed");
    self.zombie_think_done = 1;
}

// Namespace zm_spawner
// Params 0, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_e83d635c
// Checksum 0xaddc3bd1, Offset: 0x2a70
// Size: 0xf6
function zombie_entered_playable() {
    self endon(#"death");
    if (!isdefined(level.playable_areas)) {
        level.playable_areas = getentarray("player_volume", "script_noteworthy");
    }
    while (true) {
        foreach (area in level.playable_areas) {
            if (self istouching(area)) {
                self zombie_complete_emerging_into_playable_area();
                return;
            }
        }
        wait(1);
    }
}

// Namespace zm_spawner
// Params 2, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_1352119c
// Checksum 0xf23e83cc, Offset: 0x2b70
// Size: 0x278
function function_1352119c(node, var_1b8f782b) {
    assert(!self.isdog);
    self endon(#"death");
    self endon(#"stop_zombie_goto_entrance");
    level endon(#"intermission");
    self.ai_state = "zombie_goto_entrance";
    if (isdefined(var_1b8f782b) && var_1b8f782b) {
        self endon(#"bad_path");
    }
    self zombie_history("zombie_goto_entrance -> start goto entrance " + node.origin);
    self.got_to_entrance = 0;
    self.goalradius = -128;
    self setgoal(node.origin);
    self waittill(#"goal");
    self.got_to_entrance = 1;
    self zombie_history("zombie_goto_entrance -> reached goto entrance " + node.origin);
    self function_e322411();
    if (isdefined(level.var_44045a8b)) {
        self [[ level.var_44045a8b ]]();
    }
    var_efd55a29 = [];
    var_efd55a29[0] = "m";
    var_efd55a29[1] = "r";
    var_efd55a29[2] = "l";
    self.barricade_enter = 1;
    animstate = zombie_utility::append_missing_legs_suffix("zm_barricade_enter");
    self animscripted("barricade_enter_anim", self.first_node.zbarrier.origin, self.first_node.zbarrier.angles, "ai_zombie_barricade_enter_m_v1");
    zombie_shared::donotetracks("barricade_enter_anim");
    self zombie_setup_attack_properties();
    self zombie_complete_emerging_into_playable_area();
    self.barricade_enter = 0;
}

// Namespace zm_spawner
// Params 0, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_888947fc
// Checksum 0x48494aa9, Offset: 0x2df0
// Size: 0x3a4
function zombie_assure_node() {
    self endon(#"death");
    self endon(#"goal");
    level endon(#"intermission");
    start_pos = self.origin;
    if (isdefined(self.entrance_nodes)) {
        for (i = 0; i < self.entrance_nodes.size; i++) {
            if (self zombie_bad_path()) {
                self zombie_history("zombie_assure_node -> assigned assured node = " + self.entrance_nodes[i].origin);
                println("stand" + self.origin + "stand" + self.entrance_nodes[i].origin);
                level thread zm_utility::draw_line_ent_to_pos(self, self.entrance_nodes[i].origin, "goal");
                self.first_node = self.entrance_nodes[i];
                self setgoal(self.entrance_nodes[i].origin);
                continue;
            }
            return;
        }
    }
    wait(2);
    nodes = array::get_all_closest(self.origin, level.exterior_goals, undefined, 20);
    if (isdefined(nodes)) {
        self.entrance_nodes = nodes;
        for (i = 0; i < self.entrance_nodes.size; i++) {
            if (self zombie_bad_path()) {
                self zombie_history("zombie_assure_node -> assigned assured node = " + self.entrance_nodes[i].origin);
                println("stand" + self.origin + "stand" + self.entrance_nodes[i].origin);
                level thread zm_utility::draw_line_ent_to_pos(self, self.entrance_nodes[i].origin, "goal");
                self.first_node = self.entrance_nodes[i];
                self setgoal(self.entrance_nodes[i].origin);
                continue;
            }
            return;
        }
    }
    self zombie_history("zombie_assure_node -> failed to find a good entrance point");
    wait(20);
    self dodamage(self.health + 10, self.origin);
    if (isdefined(level.put_timed_out_zombies_back_in_queue) && level.put_timed_out_zombies_back_in_queue && !(isdefined(self.has_been_damaged_by_player) && self.has_been_damaged_by_player)) {
        level.zombie_total++;
        level.zombie_total_subtract++;
    }
    level.zombies_timeout_spawn++;
}

// Namespace zm_spawner
// Params 0, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_a192423b
// Checksum 0x9828a6ea, Offset: 0x31a0
// Size: 0x7e
function zombie_bad_path() {
    self endon(#"death");
    self endon(#"goal");
    self thread function_84802c0d();
    self thread function_fd21703f();
    self.zombie_bad_path = undefined;
    while (!isdefined(self.zombie_bad_path)) {
        wait(0.05);
    }
    self notify(#"hash_abd58e90");
    return self.zombie_bad_path;
}

// Namespace zm_spawner
// Params 0, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_84802c0d
// Checksum 0x4ffd58bb, Offset: 0x3228
// Size: 0x34
function function_84802c0d() {
    self endon(#"death");
    self endon(#"hash_abd58e90");
    self waittill(#"bad_path");
    self.zombie_bad_path = 1;
}

// Namespace zm_spawner
// Params 0, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_fd21703f
// Checksum 0x9c9d9a33, Offset: 0x3268
// Size: 0x2c
function function_fd21703f() {
    self endon(#"death");
    self endon(#"hash_abd58e90");
    wait(2);
    self.zombie_bad_path = 0;
}

// Namespace zm_spawner
// Params 0, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_e322411
// Checksum 0x95122476, Offset: 0x32a0
// Size: 0x790
function function_e322411() {
    self endon(#"death");
    self endon(#"teleporting");
    self zombie_history("tear_into_building -> start");
    while (true) {
        if (isdefined(self.first_node.script_noteworthy)) {
            if (self.first_node.script_noteworthy == "no_blocker") {
                return;
            }
        }
        if (!isdefined(self.first_node.target)) {
            return;
        }
        if (zm_utility::all_chunks_destroyed(self.first_node, self.first_node.barrier_chunks)) {
            self zombie_history("tear_into_building -> all chunks destroyed");
        }
        if (!get_attack_spot(self.first_node)) {
            self zombie_history("tear_into_building -> Could not find an attack spot");
            self thread do_a_taunt();
            wait(0.5);
            continue;
        }
        self.goalradius = 2;
        self.at_entrance_tear_spot = 0;
        if (isdefined(level.var_3124ae14)) {
            self [[ level.var_3124ae14 ]]();
        } else {
            angles = self.first_node.zbarrier.angles;
            self setgoal(self.attacking_spot);
        }
        self waittill(#"goal");
        self.at_entrance_tear_spot = 1;
        if (isdefined(level.var_e99062d2)) {
            self [[ level.var_e99062d2 ]]();
        } else {
            self util::function_183e3618(1, "orientdone", "death", "teleporting");
        }
        self zombie_history("tear_into_building -> Reach position and orientated");
        if (zm_utility::all_chunks_destroyed(self.first_node, self.first_node.barrier_chunks)) {
            self zombie_history("tear_into_building -> all chunks destroyed");
            for (i = 0; i < self.first_node.attack_spots_taken.size; i++) {
                self.first_node.attack_spots_taken[i] = 0;
            }
            return;
        }
        while (true) {
            if (isdefined(self.var_cbce0122)) {
                self [[ self.var_cbce0122 ]]();
            }
            self.chunk = zm_utility::get_closest_non_destroyed_chunk(self.origin, self.first_node, self.first_node.barrier_chunks);
            if (!isdefined(self.chunk)) {
                if (!zm_utility::all_chunks_destroyed(self.first_node, self.first_node.barrier_chunks)) {
                    attack = self should_attack_player_thru_boards();
                    if (isdefined(attack) && !attack && !self.missinglegs) {
                        self do_a_taunt();
                    } else {
                        wait(0.1);
                    }
                    continue;
                }
                for (i = 0; i < self.first_node.attack_spots_taken.size; i++) {
                    self.first_node.attack_spots_taken[i] = 0;
                }
                return;
            }
            self zombie_history("tear_into_building -> animating");
            self.first_node.zbarrier setzbarrierpiecestate(self.chunk, "targetted_by_zombie");
            self.first_node thread check_zbarrier_piece_for_zombie_inert(self.chunk, self.first_node.zbarrier, self);
            self.first_node thread check_zbarrier_piece_for_zombie_death(self.chunk, self.first_node.zbarrier, self);
            self notify(#"bhtn_action_notify", "teardown");
            self animscripted("tear_anim", self.first_node.zbarrier.origin, self.first_node.zbarrier.angles, "ai_zombie_boardtear_aligned_m_1_grab");
            self zombie_tear_notetracks("tear_anim", self.chunk, self.first_node);
            while (0 < self.first_node.zbarrier.chunk_health[self.chunk]) {
                self animscripted("tear_anim", self.first_node.zbarrier.origin, self.first_node.zbarrier.angles, "ai_zombie_boardtear_aligned_m_1_hold");
                self zombie_tear_notetracks("tear_anim", self.chunk, self.first_node);
                self.first_node.zbarrier.chunk_health[self.chunk]--;
            }
            self animscripted("tear_anim", self.first_node.zbarrier.origin, self.first_node.zbarrier.angles, "ai_zombie_boardtear_aligned_m_1_pull");
            self waittill(#"hash_cc2ddc9");
            self.lastchunk_destroy_time = gettime();
            attack = self should_attack_player_thru_boards();
            if (isdefined(attack) && !attack && !self.missinglegs) {
                self do_a_taunt();
            }
            if (zm_utility::all_chunks_destroyed(self.first_node, self.first_node.barrier_chunks)) {
                for (i = 0; i < self.first_node.attack_spots_taken.size; i++) {
                    self.first_node.attack_spots_taken[i] = 0;
                }
                level notify(#"hash_d17b0d74", self.first_node.zbarrier.origin);
                return;
            }
        }
        self zombie_utility::reset_attack_spot();
    }
}

// Namespace zm_spawner
// Params 0, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_6c8781ef
// Checksum 0x31b2dac2, Offset: 0x3a38
// Size: 0x1cc
function do_a_taunt() {
    self endon(#"death");
    if (self.missinglegs) {
        return 0;
    }
    if (!self.first_node.zbarrier zbarriersupportszombietaunts()) {
        return;
    }
    self.old_origin = self.origin;
    if (getdvarstring("zombie_taunt_freq") == "") {
        setdvar("zombie_taunt_freq", "5");
    }
    freq = getdvarint("zombie_taunt_freq");
    if (freq >= randomint(100)) {
        self notify(#"bhtn_action_notify", "taunt");
        tauntstate = "zm_taunt";
        if (isdefined(self.first_node.zbarrier) && self.first_node.zbarrier getzbarriertauntanimstate() != "") {
            tauntstate = self.first_node.zbarrier getzbarriertauntanimstate();
        }
        self animscripted("taunt_anim", self.origin, self.angles, "ai_zombie_taunts_4");
        self taunt_notetracks("taunt_anim");
    }
}

// Namespace zm_spawner
// Params 1, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_53deb81a
// Checksum 0xcd4ff39d, Offset: 0x3c10
// Size: 0x6a
function taunt_notetracks(msg) {
    self endon(#"death");
    while (true) {
        notetrack = self waittill(msg);
        if (notetrack == "end") {
            self forceteleport(self.old_origin);
            return;
        }
    }
}

// Namespace zm_spawner
// Params 0, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_68350f1
// Checksum 0x4f13855a, Offset: 0x3c88
// Size: 0x330
function should_attack_player_thru_boards() {
    if (self.missinglegs) {
        return false;
    }
    if (isdefined(self.first_node.zbarrier)) {
        if (!self.first_node.zbarrier zbarriersupportszombiereachthroughattacks()) {
            return false;
        }
    }
    if (getdvarstring("zombie_reachin_freq") == "") {
        setdvar("zombie_reachin_freq", "50");
    }
    freq = getdvarint("zombie_reachin_freq");
    players = getplayers();
    attack = 0;
    self.player_targets = [];
    for (i = 0; i < players.size; i++) {
        if (isalive(players[i]) && !isdefined(players[i].revivetrigger) && distance2d(self.origin, players[i].origin) <= level.attack_player_thru_boards_range && !(isdefined(players[i].zombie_vars["zombie_powerup_zombie_blood_on"]) && players[i].zombie_vars["zombie_powerup_zombie_blood_on"])) {
            self.player_targets[self.player_targets.size] = players[i];
            attack = 1;
        }
    }
    if (!attack || freq < randomint(100)) {
        return false;
    }
    self.old_origin = self.origin;
    attackanimstate = "zm_window_melee";
    if (isdefined(self.first_node.zbarrier) && self.first_node.zbarrier getzbarrierreachthroughattackanimstate() != "") {
        attackanimstate = self.first_node.zbarrier getzbarrierreachthroughattackanimstate();
    }
    self notify(#"bhtn_action_notify", "attack");
    self animscripted("window_melee_anim", self.origin, self.angles, "ai_zombie_window_attack_arm_l_out");
    self window_notetracks("window_melee_anim");
    return true;
}

// Namespace zm_spawner
// Params 1, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_1eeede10
// Checksum 0xc54a1e44, Offset: 0x3fc0
// Size: 0x2d8
function window_notetracks(msg) {
    self endon(#"death");
    while (true) {
        notetrack = self waittill(msg);
        if (notetrack == "end") {
            self teleport(self.old_origin);
            return;
        }
        if (notetrack == "fire") {
            if (self.ignoreall) {
                self.ignoreall = 0;
            }
            if (isdefined(self.first_node)) {
                var_e480bc3e = 8100;
                if (isdefined(level.attack_player_thru_boards_range)) {
                    var_e480bc3e = level.attack_player_thru_boards_range * level.attack_player_thru_boards_range;
                }
                var_be441b7e = 2601;
                for (i = 0; i < self.player_targets.size; i++) {
                    playerdistsq = distance2dsquared(self.player_targets[i].origin, self.origin);
                    heightdiff = abs(self.player_targets[i].origin[2] - self.origin[2]);
                    if (playerdistsq < var_e480bc3e && heightdiff * heightdiff < var_e480bc3e) {
                        triggerdistsq = distance2dsquared(self.player_targets[i].origin, self.first_node.trigger_location.origin);
                        heightdiff = abs(self.player_targets[i].origin[2] - self.first_node.trigger_location.origin[2]);
                        if (triggerdistsq < var_be441b7e && heightdiff * heightdiff < var_be441b7e) {
                            self.player_targets[i] dodamage(self.meleedamage, self.origin, self, self, "none", "MOD_MELEE");
                            break;
                        }
                    }
                }
                continue;
            }
            self melee();
        }
    }
}

// Namespace zm_spawner
// Params 1, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_9caec431
// Checksum 0xa13f7de6, Offset: 0x42a0
// Size: 0xd0
function get_attack_spot(node) {
    index = get_attack_spot_index(node);
    if (!isdefined(index)) {
        return false;
    }
    /#
        val = getdvarint("stand");
        if (val > -1) {
            index = val;
        }
    #/
    self.attacking_node = node;
    self.attacking_spot_index = index;
    node.attack_spots_taken[index] = 1;
    self.attacking_spot = node.attack_spots[index];
    return true;
}

// Namespace zm_spawner
// Params 1, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_aa5294e8
// Checksum 0x894f9735, Offset: 0x4378
// Size: 0xc8
function get_attack_spot_index(node) {
    indexes = [];
    if (!isdefined(node.attack_spots)) {
        node.attack_spots = [];
    }
    for (i = 0; i < node.attack_spots.size; i++) {
        if (!node.attack_spots_taken[i]) {
            indexes[indexes.size] = i;
        }
    }
    if (indexes.size == 0) {
        return undefined;
    }
    return indexes[randomint(indexes.size)];
}

// Namespace zm_spawner
// Params 3, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_62a43d81
// Checksum 0x5f01bb50, Offset: 0x4448
// Size: 0xd8
function zombie_tear_notetracks(msg, chunk, node) {
    self endon(#"death");
    while (true) {
        notetrack = self waittill(msg);
        if (notetrack == "end") {
            return;
        }
        if (notetrack == "board" || notetrack == "destroy_piece" || notetrack == "bar") {
            if (isdefined(level.zbarrier_zombie_tear_notetrack_override)) {
                self thread [[ level.zbarrier_zombie_tear_notetrack_override ]](node, chunk);
            }
            node.zbarrier setzbarrierpiecestate(chunk, "opening");
        }
    }
}

// Namespace zm_spawner
// Params 2, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_564f322
// Checksum 0x2c7346f2, Offset: 0x4528
// Size: 0x394
function zombie_boardtear_offset_fx_horizontle(chunk, node) {
    if (chunk.script_parameters == "repair_board" || isdefined(chunk.script_parameters) && chunk.script_parameters == "board") {
        if (isdefined(chunk.unbroken) && chunk.unbroken == 1) {
            if (isdefined(chunk.material) && chunk.material == "glass") {
                playfx(level._effect["glass_break"], chunk.origin, node.angles);
                chunk.unbroken = 0;
            } else if (isdefined(chunk.material) && chunk.material == "metal") {
                playfx(level._effect["fx_zombie_bar_break"], chunk.origin);
                chunk.unbroken = 0;
            } else if (isdefined(chunk.material) && chunk.material == "rock") {
                if (isdefined(level.use_clientside_rock_tearin_fx) && level.use_clientside_rock_tearin_fx) {
                    chunk clientfield::set("tearin_rock_fx", 1);
                } else {
                    playfx(level._effect["wall_break"], chunk.origin);
                }
                chunk.unbroken = 0;
            }
        }
    }
    if (isdefined(chunk.script_parameters) && chunk.script_parameters == "barricade_vents") {
        if (isdefined(level.use_clientside_board_fx) && level.use_clientside_board_fx) {
            chunk clientfield::set("tearin_board_vertical_fx", 1);
        } else {
            playfx(level._effect["fx_zombie_bar_break"], chunk.origin);
        }
        return;
    }
    if (isdefined(chunk.material) && chunk.material == "rock") {
        if (isdefined(level.use_clientside_rock_tearin_fx) && level.use_clientside_rock_tearin_fx) {
            chunk clientfield::set("tearin_rock_fx", 1);
        }
        return;
    }
    if (isdefined(level.use_clientside_board_fx)) {
        chunk clientfield::set("tearin_board_vertical_fx", 1);
        return;
    }
    wait(randomfloatrange(0.2, 0.4));
}

// Namespace zm_spawner
// Params 2, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_275f0bb0
// Checksum 0x81f82b71, Offset: 0x48c8
// Size: 0x38c
function zombie_boardtear_offset_fx_verticle(chunk, node) {
    if (chunk.script_parameters == "repair_board" || isdefined(chunk.script_parameters) && chunk.script_parameters == "board") {
        if (isdefined(chunk.unbroken) && chunk.unbroken == 1) {
            if (isdefined(chunk.material) && chunk.material == "glass") {
                playfx(level._effect["glass_break"], chunk.origin, node.angles);
                chunk.unbroken = 0;
            } else if (isdefined(chunk.material) && chunk.material == "metal") {
                playfx(level._effect["fx_zombie_bar_break"], chunk.origin);
                chunk.unbroken = 0;
            } else if (isdefined(chunk.material) && chunk.material == "rock") {
                if (isdefined(level.use_clientside_rock_tearin_fx) && level.use_clientside_rock_tearin_fx) {
                    chunk clientfield::set("tearin_rock_fx", 1);
                } else {
                    playfx(level._effect["wall_break"], chunk.origin);
                }
                chunk.unbroken = 0;
            }
        }
    }
    if (isdefined(chunk.script_parameters) && chunk.script_parameters == "barricade_vents") {
        if (isdefined(level.use_clientside_board_fx)) {
            chunk clientfield::set("tearin_board_horizontal_fx", 1);
        } else {
            playfx(level._effect["fx_zombie_bar_break"], chunk.origin);
        }
        return;
    }
    if (isdefined(chunk.material) && chunk.material == "rock") {
        if (isdefined(level.use_clientside_rock_tearin_fx) && level.use_clientside_rock_tearin_fx) {
            chunk clientfield::set("tearin_rock_fx", 1);
        }
        return;
    }
    if (isdefined(level.use_clientside_board_fx)) {
        chunk clientfield::set("tearin_board_horizontal_fx", 1);
        return;
    }
    wait(randomfloatrange(0.2, 0.4));
}

// Namespace zm_spawner
// Params 1, eflags: 0x0
// namespace_ae969b2b<file_0>::function_f46efee5
// Checksum 0x455f089c, Offset: 0x4c60
// Size: 0x5ae
function zombie_bartear_offset_fx_verticle(chunk) {
    if (isdefined(chunk.script_parameters) && chunk.script_parameters == "bar" || chunk.script_noteworthy == "board") {
        possible_tag_array_1 = [];
        possible_tag_array_1[0] = "Tag_fx_top";
        possible_tag_array_1[1] = "";
        possible_tag_array_1[2] = "Tag_fx_top";
        possible_tag_array_1[3] = "";
        possible_tag_array_2 = [];
        possible_tag_array_2[0] = "";
        possible_tag_array_2[1] = "Tag_fx_bottom";
        possible_tag_array_2[2] = "";
        possible_tag_array_2[3] = "Tag_fx_bottom";
        possible_tag_array_2 = array::randomize(possible_tag_array_2);
        random_fx = [];
        random_fx[0] = level._effect["fx_zombie_bar_break"];
        random_fx[1] = level._effect["fx_zombie_bar_break_lite"];
        random_fx[2] = level._effect["fx_zombie_bar_break"];
        random_fx[3] = level._effect["fx_zombie_bar_break_lite"];
        random_fx = array::randomize(random_fx);
        switch (randomint(9)) {
        case 0:
            playfxontag(level._effect["fx_zombie_bar_break_lite"], chunk, "Tag_fx_top");
            wait(randomfloatrange(0, 0.3));
            playfxontag(level._effect["fx_zombie_bar_break_lite"], chunk, "Tag_fx_bottom");
            break;
        case 1:
            playfxontag(level._effect["fx_zombie_bar_break"], chunk, "Tag_fx_top");
            wait(randomfloatrange(0, 0.3));
            playfxontag(level._effect["fx_zombie_bar_break"], chunk, "Tag_fx_bottom");
            break;
        case 2:
            playfxontag(level._effect["fx_zombie_bar_break_lite"], chunk, "Tag_fx_top");
            wait(randomfloatrange(0, 0.3));
            playfxontag(level._effect["fx_zombie_bar_break"], chunk, "Tag_fx_bottom");
            break;
        case 3:
            playfxontag(level._effect["fx_zombie_bar_break"], chunk, "Tag_fx_top");
            wait(randomfloatrange(0, 0.3));
            playfxontag(level._effect["fx_zombie_bar_break_lite"], chunk, "Tag_fx_bottom");
            break;
        case 4:
            playfxontag(level._effect["fx_zombie_bar_break_lite"], chunk, "Tag_fx_top");
            wait(randomfloatrange(0, 0.3));
            playfxontag(level._effect["fx_zombie_bar_break_lite"], chunk, "Tag_fx_bottom");
            break;
        case 5:
            playfxontag(level._effect["fx_zombie_bar_break_lite"], chunk, "Tag_fx_top");
            break;
        case 6:
            playfxontag(level._effect["fx_zombie_bar_break_lite"], chunk, "Tag_fx_bottom");
            break;
        case 7:
            playfxontag(level._effect["fx_zombie_bar_break"], chunk, "Tag_fx_top");
            break;
        case 8:
            playfxontag(level._effect["fx_zombie_bar_break"], chunk, "Tag_fx_bottom");
            break;
        }
    }
}

// Namespace zm_spawner
// Params 1, eflags: 0x0
// namespace_ae969b2b<file_0>::function_3f3f506f
// Checksum 0x7bc1f402, Offset: 0x5218
// Size: 0x446
function zombie_bartear_offset_fx_horizontle(chunk) {
    if (isdefined(chunk.script_parameters) && chunk.script_parameters == "bar" || chunk.script_noteworthy == "board") {
        switch (randomint(10)) {
        case 0:
            playfxontag(level._effect["fx_zombie_bar_break_lite"], chunk, "Tag_fx_left");
            wait(randomfloatrange(0, 0.3));
            playfxontag(level._effect["fx_zombie_bar_break_lite"], chunk, "Tag_fx_right");
            break;
        case 1:
            playfxontag(level._effect["fx_zombie_bar_break"], chunk, "Tag_fx_left");
            wait(randomfloatrange(0, 0.3));
            playfxontag(level._effect["fx_zombie_bar_break"], chunk, "Tag_fx_right");
            break;
        case 2:
            playfxontag(level._effect["fx_zombie_bar_break_lite"], chunk, "Tag_fx_left");
            wait(randomfloatrange(0, 0.3));
            playfxontag(level._effect["fx_zombie_bar_break"], chunk, "Tag_fx_right");
            break;
        case 3:
            playfxontag(level._effect["fx_zombie_bar_break"], chunk, "Tag_fx_left");
            wait(randomfloatrange(0, 0.3));
            playfxontag(level._effect["fx_zombie_bar_break_lite"], chunk, "Tag_fx_right");
            break;
        case 4:
            playfxontag(level._effect["fx_zombie_bar_break_lite"], chunk, "Tag_fx_left");
            wait(randomfloatrange(0, 0.3));
            playfxontag(level._effect["fx_zombie_bar_break_lite"], chunk, "Tag_fx_right");
            break;
        case 5:
            playfxontag(level._effect["fx_zombie_bar_break_lite"], chunk, "Tag_fx_left");
            break;
        case 6:
            playfxontag(level._effect["fx_zombie_bar_break_lite"], chunk, "Tag_fx_right");
            break;
        case 7:
            playfxontag(level._effect["fx_zombie_bar_break"], chunk, "Tag_fx_right");
            break;
        case 8:
            playfxontag(level._effect["fx_zombie_bar_break"], chunk, "Tag_fx_right");
            break;
        }
    }
}

// Namespace zm_spawner
// Params 3, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_2030d172
// Checksum 0x535ae2c8, Offset: 0x5668
// Size: 0x84
function check_zbarrier_piece_for_zombie_inert(chunk_index, zbarrier, zombie) {
    zombie endon(#"completed_emerging_into_playable_area");
    zombie waittill(#"stop_zombie_goto_entrance");
    if (zbarrier getzbarrierpiecestate(chunk_index) == "targetted_by_zombie") {
        zbarrier setzbarrierpiecestate(chunk_index, "closed");
    }
}

// Namespace zm_spawner
// Params 3, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_3d49c138
// Checksum 0x332c081, Offset: 0x56f8
// Size: 0xa4
function check_zbarrier_piece_for_zombie_death(chunk_index, zbarrier, zombie) {
    while (true) {
        if (zbarrier getzbarrierpiecestate(chunk_index) != "targetted_by_zombie") {
            return;
        }
        if (!isdefined(zombie) || !isalive(zombie)) {
            zbarrier setzbarrierpiecestate(chunk_index, "closed");
            return;
        }
        wait(0.05);
    }
}

// Namespace zm_spawner
// Params 1, eflags: 0x0
// namespace_ae969b2b<file_0>::function_5d6ff2ef
// Checksum 0xe9f4eee5, Offset: 0x57a8
// Size: 0x3c
function check_for_zombie_death(zombie) {
    self endon(#"destroyed");
    wait(2.5);
    self zm_blockers::update_states("repaired");
}

// Namespace zm_spawner
// Params 0, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_bb892ca5
// Checksum 0xc7361f41, Offset: 0x57f0
// Size: 0x2a
function player_can_score_from_zombies() {
    if (isdefined(self.inhibit_scoring_from_zombies) && isdefined(self) && self.inhibit_scoring_from_zombies) {
        return false;
    }
    return true;
}

// Namespace zm_spawner
// Params 1, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_d6c178a8
// Checksum 0x77ef676b, Offset: 0x5828
// Size: 0x174
function zombie_can_drop_powerups(zombie) {
    if (zm_utility::is_tactical_grenade(zombie.damageweapon) || !level flag::get("zombie_drop_powerups")) {
        return false;
    }
    if (isdefined(zombie.no_powerups) && zombie.no_powerups) {
        return false;
    }
    if (isdefined(level.no_powerups) && level.no_powerups) {
        return false;
    }
    if (isdefined(level.use_powerup_volumes) && level.use_powerup_volumes) {
        volumes = getentarray("no_powerups", "targetname");
        foreach (volume in volumes) {
            if (zombie istouching(volume)) {
                return false;
            }
        }
    }
    return true;
}

// Namespace zm_spawner
// Params 1, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_1b6af62e
// Checksum 0x595c1424, Offset: 0x59a8
// Size: 0x34
function function_1b6af62e(origin) {
    util::wait_network_frame();
    level thread zm_powerups::powerup_drop(origin);
}

// Namespace zm_spawner
// Params 6, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_b3a70386
// Checksum 0x59632ad0, Offset: 0x59e8
// Size: 0x358
function zombie_death_points(origin, mod, hit_location, attacker, zombie, team) {
    if (!isdefined(attacker) || !isplayer(attacker)) {
        return;
    }
    if (!attacker player_can_score_from_zombies()) {
        zombie.marked_for_recycle = 1;
        return;
    }
    if (zombie_can_drop_powerups(zombie)) {
        if (isdefined(zombie.in_the_ground) && zombie.in_the_ground == 1) {
            trace = bullettrace(zombie.origin + (0, 0, 100), zombie.origin + (0, 0, -100), 0, undefined);
            origin = trace["position"];
            level thread function_1b6af62e(origin);
        } else {
            trace = groundtrace(zombie.origin + (0, 0, 5), zombie.origin + (0, 0, -300), 0, undefined);
            origin = trace["position"];
            level thread function_1b6af62e(origin);
        }
    }
    level thread zm_audio::player_zombie_kill_vox(hit_location, attacker, mod, zombie);
    event = "death";
    if (mod == "MOD_MELEE" || zombie.damageweapon.isballisticknife && mod == "MOD_IMPACT") {
        event = "ballistic_knife_death";
    }
    if (isdefined(zombie.deathpoints_already_given) && zombie.deathpoints_already_given) {
        return;
    }
    zombie.deathpoints_already_given = 1;
    if (zm_equipment::is_equipment(zombie.damageweapon)) {
        return;
    }
    death_weapon = attacker.currentweapon;
    if (isdefined(zombie.damageweapon)) {
        death_weapon = zombie.damageweapon;
    }
    if (isdefined(attacker)) {
        attacker zm_score::player_add_points(event, mod, hit_location, undefined, team, death_weapon);
    }
    if (isdefined(level.hero_power_update)) {
        level thread [[ level.hero_power_update ]](attacker, zombie);
    }
}

// Namespace zm_spawner
// Params 1, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_25fa2662
// Checksum 0xc50ddd77, Offset: 0x5d48
// Size: 0x5e
function get_number_variants(aliasprefix) {
    for (i = 0; i < 100; i++) {
        if (!soundexists(aliasprefix + "_" + i)) {
            return i;
        }
    }
}

// Namespace zm_spawner
// Params 0, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_1d18889c
// Checksum 0x9cbb822d, Offset: 0x5db0
// Size: 0x284
function function_1d18889c() {
    if (self.isdog) {
        return;
    }
    if (!isdefined(level._effect) || !isdefined(level._effect["character_fire_death_sm"])) {
        println("stand");
        return;
    }
    playfxontag(level._effect["character_fire_death_sm"], self, "J_SpineLower");
    tagarray = [];
    if (!isdefined(self.a.gib_ref) || self.a.gib_ref != "left_arm") {
        tagarray[tagarray.size] = "J_Elbow_LE";
        tagarray[tagarray.size] = "J_Wrist_LE";
    }
    if (!isdefined(self.a.gib_ref) || self.a.gib_ref != "right_arm") {
        tagarray[tagarray.size] = "J_Elbow_RI";
        tagarray[tagarray.size] = "J_Wrist_RI";
    }
    if (self.a.gib_ref != "no_legs" && (!isdefined(self.a.gib_ref) || self.a.gib_ref != "left_leg")) {
        tagarray[tagarray.size] = "J_Knee_LE";
        tagarray[tagarray.size] = "J_Ankle_LE";
    }
    if (self.a.gib_ref != "no_legs" && (!isdefined(self.a.gib_ref) || self.a.gib_ref != "right_leg")) {
        tagarray[tagarray.size] = "J_Knee_RI";
        tagarray[tagarray.size] = "J_Ankle_RI";
    }
    tagarray = array::randomize(tagarray);
    playfxontag(level._effect["character_fire_death_sm"], self, tagarray[0]);
}

// Namespace zm_spawner
// Params 2, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_aff3c129
// Checksum 0xf2289e84, Offset: 0x6040
// Size: 0x16c
function zombie_ragdoll_then_explode(launchvector, attacker) {
    if (!isdefined(self)) {
        return;
    }
    self zombie_utility::zombie_eye_glow_stop();
    self clientfield::set("zombie_ragdoll_explode", 1);
    self notify(#"exploding");
    self notify(#"end_melee");
    self notify(#"death", attacker);
    self.dont_die_on_me = 1;
    self.exploding = 1;
    self.a.nodeath = 1;
    self.dont_throw_gib = 1;
    self startragdoll();
    self setplayercollision(0);
    self zombie_utility::reset_attack_spot();
    if (isdefined(launchvector)) {
        self launchragdoll(launchvector);
    }
    wait(2.1);
    if (isdefined(self)) {
        self ghost();
        self util::delay(0.25, undefined, &zm_utility::self_delete);
    }
}

// Namespace zm_spawner
// Params 8, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_6cf4945d
// Checksum 0xea00cb7e, Offset: 0x61b8
// Size: 0x39c
function zombie_death_animscript(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
    team = undefined;
    zm_utility::function_20fdac8();
    if (isdefined(self._race_team)) {
        team = self._race_team;
    }
    self zombie_utility::reset_attack_spot();
    if (self check_zombie_death_animscript_callbacks()) {
        return false;
    }
    if (isdefined(level.var_9ca5d500)) {
        self [[ level.var_9ca5d500 ]]();
    }
    self.grenadeammo = 0;
    if (isdefined(self.nuked)) {
        if (zombie_can_drop_powerups(self)) {
            if (isdefined(self.in_the_ground) && self.in_the_ground == 1) {
                trace = bullettrace(self.origin + (0, 0, 100), self.origin + (0, 0, -100), 0, undefined);
                origin = trace["position"];
                level thread function_1b6af62e(origin);
            } else {
                trace = groundtrace(self.origin + (0, 0, 5), self.origin + (0, 0, -300), 0, undefined);
                origin = trace["position"];
                level thread function_1b6af62e(self.origin);
            }
        }
    } else {
        level zombie_death_points(self.origin, self.damagemod, self.damagelocation, self.attacker, self, team);
    }
    if (isdefined(self.attacker) && isai(self.attacker)) {
        self.attacker notify(#"killed", self);
    }
    if ("rottweil72_upgraded" == self.damageweapon.name && "MOD_RIFLE_BULLET" == self.damagemod) {
        self thread function_1d18889c();
    }
    if ("tazer_knuckles" == self.damageweapon.name && "MOD_MELEE" == self.damagemod) {
        self.is_on_fire = 0;
        self notify(#"stop_flame_damage");
    }
    if (self.damagemod == "MOD_BURNED") {
        self thread zombie_death::flame_death_fx();
    }
    if (self.damagemod == "MOD_GRENADE" || self.damagemod == "MOD_GRENADE_SPLASH") {
        level notify(#"zombie_grenade_death", self.origin);
    }
    return false;
}

// Namespace zm_spawner
// Params 0, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_1538b29d
// Checksum 0xe0fb9317, Offset: 0x6560
// Size: 0x62
function check_zombie_death_animscript_callbacks() {
    if (!isdefined(level.zombie_death_animscript_callbacks)) {
        return false;
    }
    for (i = 0; i < level.zombie_death_animscript_callbacks.size; i++) {
        if (self [[ level.zombie_death_animscript_callbacks[i] ]]()) {
            return true;
        }
    }
    return false;
}

// Namespace zm_spawner
// Params 1, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_6a0e8009
// Checksum 0xf16fff1a, Offset: 0x65d0
// Size: 0x3a
function register_zombie_death_animscript_callback(func) {
    if (!isdefined(level.zombie_death_animscript_callbacks)) {
        level.zombie_death_animscript_callbacks = [];
    }
    level.zombie_death_animscript_callbacks[level.zombie_death_animscript_callbacks.size] = func;
}

// Namespace zm_spawner
// Params 1, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_5a36459d
// Checksum 0x445cae19, Offset: 0x6618
// Size: 0x1c8
function damage_on_fire(player) {
    self endon(#"death");
    self endon(#"stop_flame_damage");
    wait(2);
    while (isdefined(self.is_on_fire) && self.is_on_fire) {
        if (level.round_number < 6) {
            dmg = level.zombie_health * randomfloatrange(0.2, 0.3);
        } else if (level.round_number < 9) {
            dmg = level.zombie_health * randomfloatrange(0.15, 0.25);
        } else if (level.round_number < 11) {
            dmg = level.zombie_health * randomfloatrange(0.1, 0.2);
        } else {
            dmg = level.zombie_health * randomfloatrange(0.1, 0.15);
        }
        if (isdefined(player) && isalive(player)) {
            self dodamage(dmg, self.origin, player);
        } else {
            self dodamage(dmg, self.origin, level);
        }
        wait(randomfloatrange(1, 3));
    }
}

// Namespace zm_spawner
// Params 1, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_26a7d5bb
// Checksum 0xa235bf48, Offset: 0x67e8
// Size: 0x6a
function player_using_hi_score_weapon(player) {
    if (isplayer(player)) {
        weapon = player getcurrentweapon();
        return (weapon == level.weaponnone || weapon.issemiauto);
    }
    return false;
}

// Namespace zm_spawner
// Params 14, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_2725c6d1
// Checksum 0x9d8e3dfe, Offset: 0x6860
// Size: 0x724
function zombie_damage(mod, hit_location, var_8a2b6fe5, player, amount, team, weapon, direction_vec, tagname, modelname, partname, dflags, inflictor, chargelevel) {
    if (zm_utility::is_magic_bullet_shield_enabled(self)) {
        return;
    }
    player.var_1f20fd1c = mod;
    if (isdefined(self.marked_for_death)) {
        return;
    }
    if (!isdefined(player)) {
        return;
    }
    if (isdefined(var_8a2b6fe5)) {
        self.damagehit_origin = var_8a2b6fe5;
    } else {
        self.damagehit_origin = player getweaponmuzzlepoint();
    }
    if (self function_466facb5(mod, hit_location, var_8a2b6fe5, player, amount, weapon, direction_vec, tagname, modelname, partname, dflags, inflictor, chargelevel)) {
        return;
    } else if (!player player_can_score_from_zombies()) {
    } else if (isdefined(weapon) && weapon.isriotshield) {
    } else if (self zombie_flame_damage(mod, player)) {
        if (self function_efdb50db()) {
            player zm_score::player_add_points("damage", mod, hit_location, self.isdog, team);
        }
    } else {
        if (player_using_hi_score_weapon(player)) {
            damage_type = "damage";
        } else {
            damage_type = "damage_light";
        }
        if (!(isdefined(self.no_damage_points) && self.no_damage_points)) {
            player zm_score::player_add_points(damage_type, mod, hit_location, self.isdog, team, weapon);
        }
    }
    if (isdefined(self.var_4492808f)) {
        self [[ self.var_4492808f ]](mod, hit_location, var_8a2b6fe5, player, direction_vec);
    }
    if ("MOD_IMPACT" != mod && zm_utility::is_placeable_mine(weapon)) {
        if (isdefined(self.var_361c69c5)) {
            self [[ self.var_361c69c5 ]](mod, hit_location, var_8a2b6fe5, player);
        } else if (isdefined(player) && isalive(player)) {
            self dodamage(level.round_number * randomintrange(100, -56), self.origin, player, self, hit_location, mod, 0, weapon);
        } else {
            self dodamage(level.round_number * randomintrange(100, -56), self.origin, undefined, self, hit_location, mod, 0, weapon);
        }
    } else if (mod == "MOD_GRENADE" || mod == "MOD_GRENADE_SPLASH") {
        if (isdefined(player) && isalive(player)) {
            player.grenade_multiattack_count++;
            player.grenade_multiattack_ent = self;
            self dodamage(level.round_number + randomintrange(100, -56), self.origin, player, self, hit_location, mod, 0, weapon);
        } else {
            self dodamage(level.round_number + randomintrange(100, -56), self.origin, undefined, self, hit_location, mod, 0, weapon);
        }
    } else if (mod == "MOD_PROJECTILE" || mod == "MOD_EXPLOSIVE" || mod == "MOD_PROJECTILE_SPLASH") {
        if (isdefined(player) && isalive(player)) {
            self dodamage(level.round_number * randomintrange(0, 100), self.origin, player, self, hit_location, mod, 0, weapon);
        } else {
            self dodamage(level.round_number * randomintrange(0, 100), self.origin, undefined, self, hit_location, mod, 0, weapon);
        }
    }
    if (isdefined(self.gibbed) && self.gibbed) {
        if (isdefined(self.missinglegs) && self.missinglegs && isalive(self)) {
            if (isdefined(player)) {
                player zm_audio::create_and_play_dialog("general", "crawl_spawn");
            }
        } else if (self.a.gib_ref == "right_arm" || isdefined(self.a.gib_ref) && self.a.gib_ref == "left_arm") {
            if (!self.missinglegs && isalive(self)) {
                if (isdefined(player)) {
                    rand = randomintrange(0, 100);
                    if (rand < 7) {
                        player zm_audio::create_and_play_dialog("general", "shoot_arm");
                    }
                }
            }
        }
    }
    self thread zm_powerups::function_3308d17f(player, mod, hit_location);
}

// Namespace zm_spawner
// Params 14, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_d0cf525a
// Checksum 0xa204560c, Offset: 0x6f90
// Size: 0x28c
function function_d0cf525a(mod, hit_location, var_8a2b6fe5, player, amount, team, weapon, direction_vec, tagname, modelname, partname, dflags, inflictor, chargelevel) {
    if (zm_utility::is_magic_bullet_shield_enabled(self)) {
        return;
    }
    player.var_1f20fd1c = mod;
    if (!isdefined(player)) {
        return;
    }
    if (isdefined(var_8a2b6fe5)) {
        self.damagehit_origin = var_8a2b6fe5;
    } else {
        self.damagehit_origin = player getweaponmuzzlepoint();
    }
    if (self function_466facb5(mod, hit_location, var_8a2b6fe5, player, amount, weapon, direction_vec, tagname, modelname, partname, dflags, inflictor, chargelevel)) {
        return;
    } else if (!player player_can_score_from_zombies()) {
    } else if (self zombie_flame_damage(mod, player)) {
        if (self function_efdb50db()) {
            player zm_score::player_add_points("damage_ads", mod, hit_location, undefined, team);
        }
    } else {
        if (player_using_hi_score_weapon(player)) {
            damage_type = "damage";
        } else {
            damage_type = "damage_light";
        }
        if (!(isdefined(self.no_damage_points) && self.no_damage_points)) {
            player zm_score::player_add_points(damage_type, mod, hit_location, undefined, team, weapon);
        }
    }
    if (isdefined(self.var_4492808f)) {
        self [[ self.var_4492808f ]](mod, hit_location, var_8a2b6fe5, player, direction_vec);
    }
    self thread zm_powerups::function_3308d17f(player, mod, hit_location);
}

// Namespace zm_spawner
// Params 13, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_466facb5
// Checksum 0x257bee37, Offset: 0x7228
// Size: 0xfe
function function_466facb5(mod, hit_location, var_8a2b6fe5, player, amount, weapon, direction_vec, tagname, modelname, partname, dflags, inflictor, chargelevel) {
    if (!isdefined(level.var_1275b6c4)) {
        return false;
    }
    for (i = 0; i < level.var_1275b6c4.size; i++) {
        if (self [[ level.var_1275b6c4[i] ]](mod, hit_location, var_8a2b6fe5, player, amount, weapon, direction_vec, tagname, modelname, partname, dflags, inflictor, chargelevel)) {
            return true;
        }
    }
    return false;
}

// Namespace zm_spawner
// Params 1, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_a1561a9d
// Checksum 0x6902322f, Offset: 0x7330
// Size: 0x3a
function register_zombie_damage_callback(func) {
    if (!isdefined(level.var_1275b6c4)) {
        level.var_1275b6c4 = [];
    }
    level.var_1275b6c4[level.var_1275b6c4.size] = func;
}

// Namespace zm_spawner
// Params 0, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_efdb50db
// Checksum 0x2f053c8c, Offset: 0x7378
// Size: 0x48
function function_efdb50db() {
    if (!isdefined(self.flame_damage_time) || gettime() > self.flame_damage_time) {
        self.flame_damage_time = gettime() + level.zombie_vars["zombie_flame_dmg_point_delay"];
        return true;
    }
    return false;
}

// Namespace zm_spawner
// Params 2, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_6293b965
// Checksum 0x52986543, Offset: 0x73c8
// Size: 0x16c
function zombie_flame_damage(mod, player) {
    if (mod == "MOD_BURNED") {
        if (isdefined(self.is_on_fire) && (!isdefined(self.is_on_fire) || !self.is_on_fire)) {
            self thread damage_on_fire(player);
        }
        do_flame_death = 1;
        dist = 10000;
        ai = getaiteamarray(level.zombie_team);
        for (i = 0; i < ai.size; i++) {
            if (isdefined(ai[i].is_on_fire) && ai[i].is_on_fire) {
                if (distancesquared(ai[i].origin, self.origin) < dist) {
                    do_flame_death = 0;
                    break;
                }
            }
        }
        if (do_flame_death) {
            self thread zombie_death::flame_death_fx();
        }
        return true;
    }
    return false;
}

// Namespace zm_spawner
// Params 1, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_1acb147f
// Checksum 0xe9b9123a, Offset: 0x7540
// Size: 0x24
function is_weapon_shotgun(weapon) {
    return weapon.weapclass == "spread";
}

// Namespace zm_spawner
// Params 1, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_479c8f18
// Checksum 0x3edc84e4, Offset: 0x7570
// Size: 0x12c
function zombie_explodes_intopieces(random_gibs) {
    if (isdefined(self) && isactor(self)) {
        if (!random_gibs || randomint(100) < 50) {
            gibserverutils::gibhead(self);
        }
        if (!random_gibs || randomint(100) < 50) {
            gibserverutils::gibleftarm(self);
        }
        if (!random_gibs || randomint(100) < 50) {
            gibserverutils::gibrightarm(self);
        }
        if (!random_gibs || randomint(100) < 50) {
            gibserverutils::giblegs(self);
        }
    }
}

// Namespace zm_spawner
// Params 1, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_a548dbb9
// Checksum 0xf0f342c3, Offset: 0x76a8
// Size: 0xbec
function zombie_death_event(zombie) {
    zombie.marked_for_recycle = 0;
    var_b7c3dd10 = 0;
    force_head_gib = 0;
    attacker = zombie waittill(#"death");
    time_of_death = gettime();
    if (isdefined(zombie)) {
        zombie stopsounds();
    }
    if (isdefined(zombie) && isdefined(zombie.marked_for_insta_upgraded_death)) {
        force_head_gib = 1;
    }
    if (isdefined(zombie) && !isdefined(zombie.damagehit_origin) && isdefined(attacker) && isalive(attacker) && !isvehicle(attacker)) {
        zombie.damagehit_origin = attacker getweaponmuzzlepoint();
    }
    if (isdefined(attacker) && isplayer(attacker) && attacker player_can_score_from_zombies()) {
        if (isdefined(zombie.script_parameters)) {
            attacker notify(#"zombie_death_params", zombie.script_parameters, isdefined(zombie.completed_emerging_into_playable_area) && zombie.completed_emerging_into_playable_area);
        }
        if (isdefined(zombie.b_widows_wine_cocoon) && isdefined(zombie.e_widows_wine_player)) {
            attacker notify(#"widows_wine_kill", zombie.e_widows_wine_player);
        }
        if (isdefined(level.var_57f7a081) && level.var_57f7a081) {
            namespace_95add22b::function_290a4934(attacker, zombie.origin);
        }
        if (isdefined(level.var_2eafd286) && level.var_2eafd286) {
            attacker namespace_25f8c2ad::function_8d1310c0(zombie, attacker);
        }
        if (isdefined(zombie) && isdefined(zombie.damagelocation)) {
            if (zm_utility::is_headshot(zombie.damageweapon, zombie.damagelocation, zombie.damagemod)) {
                attacker.headshots++;
                attacker zm_stats::increment_client_stat("headshots");
                attacker addweaponstat(zombie.damageweapon, "headshots", 1);
                attacker zm_stats::increment_player_stat("headshots");
                attacker zm_stats::increment_challenge_stat("ZOMBIE_HUNTER_KILL_HEADSHOT");
                if (zm_utility::is_classic()) {
                    attacker namespace_25f8c2ad::function_56da3688(time_of_death, zombie);
                }
            } else {
                attacker notify(#"zombie_death_no_headshot");
            }
        }
        if (isdefined(zombie) && isdefined(zombie.damagemod) && zombie.damagemod == "MOD_MELEE") {
            attacker zm_stats::increment_client_stat("melee_kills");
            attacker zm_stats::increment_player_stat("melee_kills");
            attacker notify(#"melee_kill");
            attacker zm_stats::increment_challenge_stat("ZOMBIE_HUNTER_KILL_MELEE");
            if (attacker namespace_95add22b::function_4332a58a()) {
                var_b7c3dd10 = 1;
            }
        }
        attacker demo::add_actor_bookmark_kill_time();
        attacker.kills++;
        attacker zm_stats::increment_client_stat("kills");
        attacker zm_stats::increment_player_stat("kills");
        if (isdefined(level.var_cfce124) && level.var_cfce124) {
            attacker namespace_25f8c2ad::function_b0f6b767();
        }
        if (isdefined(zombie) && isdefined(zombie.damageweapon)) {
            attacker addweaponstat(zombie.damageweapon, "kills", 1);
            if (zm_weapons::is_weapon_upgraded(zombie.damageweapon)) {
                attacker zm_stats::increment_challenge_stat("ZOMBIE_HUNTER_KILL_PACKAPUNCH");
            }
        }
        if (isdefined(zombie.missinglegs) && isdefined(zombie) && zombie.missinglegs) {
            attacker zm_stats::increment_challenge_stat("ZOMBIE_HUNTER_KILL_CRAWLER");
        }
        if (attacker namespace_25f8c2ad::function_2f3a2d06() || force_head_gib) {
            zombie zombie_utility::zombie_head_gib();
        }
        if (isdefined(level.var_f4735dd3) && level.var_f4735dd3) {
            attacker notify(#"hash_6d159f37");
        }
    }
    zm_utility::function_20fdac8();
    if (!isdefined(zombie)) {
        return;
    }
    level.global_zombies_killed++;
    if (isdefined(zombie.marked_for_death) && !isdefined(zombie.nuked)) {
        level.zombie_trap_killed_count++;
    }
    zombie check_zombie_death_event_callbacks(attacker);
    zombie bgb::actor_death_override(attacker);
    if (!isdefined(zombie)) {
        return;
    }
    name = zombie.animname;
    if (isdefined(zombie.sndname)) {
        name = zombie.sndname;
    }
    self notify(#"bhtn_action_notify", "death");
    zombie thread zombie_utility::zombie_eye_glow_stop();
    if (isactor(zombie)) {
        if (isdefined(zombie.damageweapon.doannihilate) && zombie.damageweapon.doannihilate) {
            zombie zombie_explodes_intopieces(0);
        } else if (zombie.damagemod === "MOD_GRENADE" || zombie.damagemod === "MOD_GRENADE_SPLASH" || zombie.damagemod === "MOD_EXPLOSIVE" || is_weapon_shotgun(zombie.damageweapon) && zm_weapons::is_weapon_upgraded(zombie.damageweapon) || zm_utility::is_placeable_mine(zombie.damageweapon) || var_b7c3dd10 == 1) {
            var_d40de94d = -76;
            if (isdefined(zombie.damagehit_origin) && distancesquared(zombie.origin, zombie.damagehit_origin) < var_d40de94d * var_d40de94d) {
                tag = "J_SpineLower";
                if (isdefined(zombie.isdog) && zombie.isdog) {
                    tag = "tag_origin";
                }
                if (!(isdefined(zombie.is_on_fire) && zombie.is_on_fire) && !(isdefined(zombie.guts_explosion) && zombie.guts_explosion)) {
                    zombie thread zombie_utility::zombie_gut_explosion();
                }
            }
            if (isdefined(attacker) && isplayer(attacker) && !is_weapon_shotgun(zombie.damageweapon)) {
                attacker zm_stats::increment_challenge_stat("ZOMBIE_HUNTER_KILL_EXPLOSIVES");
            }
        }
        if (zombie.damagemod === "MOD_GRENADE" || zombie.damagemod === "MOD_GRENADE_SPLASH") {
            if (isdefined(attacker) && isalive(attacker) && isplayer(attacker)) {
                attacker.grenade_multiattack_count++;
                attacker.grenade_multiattack_ent = zombie;
                attacker.grenade_multikill_count++;
            }
        }
    }
    if (isdefined(zombie.marked_for_recycle) && !(isdefined(zombie.has_been_damaged_by_player) && zombie.has_been_damaged_by_player) && zombie.marked_for_recycle) {
        level.zombie_total++;
        level.zombie_total_subtract++;
    } else if (isdefined(zombie.attacker) && isplayer(zombie.attacker)) {
        level.zombie_player_killed_count++;
        if (isdefined(zombie.sound_damage_player) && zombie.sound_damage_player == zombie.attacker) {
            zombie.attacker zm_audio::create_and_play_dialog("kill", "damage");
        }
        zombie.attacker notify(#"zom_kill", zombie);
    } else if (zombie.ignoreall && !(isdefined(zombie.marked_for_death) && zombie.marked_for_death)) {
        level.zombies_timeout_spawn++;
    }
    level notify(#"zom_kill");
    level.total_zombies_killed++;
}

// Namespace zm_spawner
// Params 1, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_2e6d7b0b
// Checksum 0xa7f7e799, Offset: 0x82a0
// Size: 0x64
function check_zombie_death_event_callbacks(attacker) {
    if (!isdefined(level.zombie_death_event_callbacks)) {
        return;
    }
    for (i = 0; i < level.zombie_death_event_callbacks.size; i++) {
        self [[ level.zombie_death_event_callbacks[i] ]](attacker);
    }
}

// Namespace zm_spawner
// Params 1, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_202d5265
// Checksum 0x4eb7c596, Offset: 0x8310
// Size: 0x3a
function register_zombie_death_event_callback(func) {
    if (!isdefined(level.zombie_death_event_callbacks)) {
        level.zombie_death_event_callbacks = [];
    }
    level.zombie_death_event_callbacks[level.zombie_death_event_callbacks.size] = func;
}

// Namespace zm_spawner
// Params 1, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_d5b5054
// Checksum 0xb2b73f21, Offset: 0x8358
// Size: 0x34
function deregister_zombie_death_event_callback(func) {
    if (isdefined(level.zombie_death_event_callbacks)) {
        arrayremovevalue(level.zombie_death_event_callbacks, func);
    }
}

// Namespace zm_spawner
// Params 0, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_f5a4e044
// Checksum 0x35116976, Offset: 0x8398
// Size: 0x60
function zombie_setup_attack_properties() {
    self zombie_history("zombie_setup_attack_properties()");
    self.ignoreall = 0;
    self.meleeattackdist = 64;
    self.maxsightdistsqrd = 16384;
    self.disablearrivals = 1;
    self.disableexits = 1;
}

// Namespace zm_spawner
// Params 0, eflags: 0x0
// namespace_ae969b2b<file_0>::function_8475ac13
// Checksum 0xf0bb20c1, Offset: 0x8400
// Size: 0x4c
function attractors_generated_listener() {
    self endon(#"death");
    level endon(#"intermission");
    self endon(#"stop_find_flesh");
    self endon(#"path_timer_done");
    level waittill(#"attractor_positions_generated");
    self.zombie_path_timer = 0;
}

// Namespace zm_spawner
// Params 0, eflags: 0x0
// namespace_ae969b2b<file_0>::function_fb112531
// Checksum 0x5530c6df, Offset: 0x8458
// Size: 0x4ac
function function_fb112531() {
    self endon(#"death");
    self endon(#"zombie_acquire_enemy");
    level endon(#"intermission");
    assert(isdefined(self.favoriteenemy) || isdefined(self.enemyoverride));
    self.var_34ddbcc8 = 1;
    self thread function_2877d890();
    self waittill(#"bad_path");
    level.zombie_pathing_failed++;
    if (isdefined(self.enemyoverride)) {
        zm_utility::debug_print("Zombie couldn't path to point of interest at origin: " + self.enemyoverride[0] + " Falling back to breadcrumb system");
        if (isdefined(self.enemyoverride[1])) {
            self.enemyoverride = self.enemyoverride[1] zm_utility::invalidate_attractor_pos(self.enemyoverride, self);
            self.zombie_path_timer = 0;
            return;
        }
    } else if (isdefined(self.favoriteenemy)) {
        zm_utility::debug_print("Zombie couldn't path to player at origin: " + self.favoriteenemy.origin + " Falling back to breadcrumb system");
    } else {
        zm_utility::debug_print("Zombie couldn't path to a player ( the other 'prefered' player might be ignored for encounters mode ). Falling back to breadcrumb system");
    }
    if (!isdefined(self.favoriteenemy)) {
        self.zombie_path_timer = 0;
        return;
    } else {
        self.favoriteenemy endon(#"disconnect");
    }
    players = getplayers();
    var_da3085b6 = 0;
    for (i = 0; i < players.size; i++) {
        if (zm_utility::is_player_valid(players[i], 1)) {
            var_da3085b6 += 1;
        }
    }
    if (players.size > 1) {
        if (isdefined(level._should_skip_ignore_player_logic) && [[ level._should_skip_ignore_player_logic ]]()) {
            self.zombie_path_timer = 0;
            return;
        }
        if (!isinarray(self.ignore_player, self.favoriteenemy)) {
            self.ignore_player[self.ignore_player.size] = self.favoriteenemy;
        }
        if (self.ignore_player.size < var_da3085b6) {
            self.zombie_path_timer = 0;
            return;
        }
    }
    var_47f4e401 = self.favoriteenemy.zombie_breadcrumbs;
    var_6e71a45d = [];
    while (true) {
        if (!zm_utility::is_player_valid(self.favoriteenemy, 1)) {
            self.zombie_path_timer = 0;
            return;
        }
        goal = function_17df5af4(self.favoriteenemy.origin, var_47f4e401, var_6e71a45d, randomint(100) < 20);
        if (!isdefined(goal)) {
            zm_utility::debug_print("Zombie exhausted breadcrumb search");
            level.zombie_breadcrumb_failed++;
            goal = self.favoriteenemy.spectator_respawn.origin;
        }
        zm_utility::debug_print("Setting current breadcrumb to " + goal);
        self.zombie_path_timer += 100;
        self setgoal(goal);
        self waittill(#"bad_path");
        zm_utility::debug_print("Zombie couldn't path to breadcrumb at " + goal + " Finding next breadcrumb");
        for (i = 0; i < var_47f4e401.size; i++) {
            if (goal == var_47f4e401[i]) {
                var_6e71a45d[var_6e71a45d.size] = i;
                break;
            }
        }
    }
}

// Namespace zm_spawner
// Params 4, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_17df5af4
// Checksum 0x9f832985, Offset: 0x8910
// Size: 0x152
function function_17df5af4(origin, breadcrumbs, var_6e71a45d, pick_random) {
    assert(isdefined(origin));
    assert(isdefined(breadcrumbs));
    assert(isarray(breadcrumbs));
    /#
        if (pick_random) {
            zm_utility::debug_print("stand");
        }
    #/
    for (i = 0; i < breadcrumbs.size; i++) {
        if (pick_random) {
            crumb_index = randomint(breadcrumbs.size);
        } else {
            crumb_index = i;
        }
        if (function_766ac331(crumb_index, var_6e71a45d)) {
            continue;
        }
        return breadcrumbs[crumb_index];
    }
    return undefined;
}

// Namespace zm_spawner
// Params 2, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_766ac331
// Checksum 0x8ba56a7, Offset: 0x8a70
// Size: 0x5a
function function_766ac331(crumb, var_6e71a45d) {
    for (i = 0; i < var_6e71a45d.size; i++) {
        if (var_6e71a45d[i] == crumb) {
            return true;
        }
    }
    return false;
}

// Namespace zm_spawner
// Params 1, eflags: 0x0
// namespace_ae969b2b<file_0>::function_401eaa59
// Checksum 0x119e348d, Offset: 0x8ad8
// Size: 0x278
function function_401eaa59(var_93aaf9e3) {
    trace_distance = 35;
    var_26337d1f = 2;
    for (index = var_93aaf9e3; isdefined(self.favoriteenemy.zombie_breadcrumbs[index + 1]); index++) {
        current_crumb = self.favoriteenemy.zombie_breadcrumbs[index];
        var_22fc19ee = self.favoriteenemy.zombie_breadcrumbs[index + 1];
        angles = vectortoangles(current_crumb - var_22fc19ee);
        right = anglestoright(angles);
        left = anglestoright(angles + (0, 180, 0));
        dist_pos = current_crumb + vectorscale(right, trace_distance);
        trace = bullettrace(current_crumb, dist_pos, 1, undefined);
        vector = trace["position"];
        if (distance(vector, current_crumb) < 17) {
            self.favoriteenemy.zombie_breadcrumbs[index] = current_crumb + vectorscale(left, var_26337d1f);
            continue;
        }
        dist_pos = current_crumb + vectorscale(left, trace_distance);
        trace = bullettrace(current_crumb, dist_pos, 1, undefined);
        vector = trace["position"];
        if (distance(vector, current_crumb) < 17) {
            self.favoriteenemy.zombie_breadcrumbs[index] = current_crumb + vectorscale(right, var_26337d1f);
            continue;
        }
    }
}

// Namespace zm_spawner
// Params 0, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_59e041ed
// Checksum 0x23ebd865, Offset: 0x8d58
// Size: 0xa4
function function_59e041ed() {
    note = 0;
    notes = [];
    for (i = 0; i < 4; i++) {
        notes[notes.size] = "zombie_repath_notify_" + i;
    }
    while (true) {
        level notify(notes[note]);
        note = (note + 1) % 4;
        wait(0.05);
    }
}

// Namespace zm_spawner
// Params 0, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_2877d890
// Checksum 0xe2a530e4, Offset: 0x8e08
// Size: 0x3e8
function function_2877d890() {
    self endon(#"death");
    self endon(#"zombie_acquire_enemy");
    self endon(#"bad_path");
    level endon(#"intermission");
    if (!isdefined(level.var_8d9c6e98)) {
        level.var_8d9c6e98 = 1;
        level thread function_59e041ed();
    }
    if (!isdefined(self.var_a00e2d08)) {
        self.var_a00e2d08 = "zombie_repath_notify_" + self getentitynumber() % 4;
    }
    while (true) {
        if (!isdefined(self.var_34ddbcc8)) {
            level waittill(self.var_a00e2d08);
        } else {
            self.var_34ddbcc8 = undefined;
        }
        if (!(isdefined(self.var_869f5c3e) && self.var_869f5c3e) && isdefined(self.enemyoverride) && isdefined(self.enemyoverride[1])) {
            if (distancesquared(self.origin, self.enemyoverride[0]) > 1) {
                self orientmode("face motion");
            } else {
                self orientmode("face point", self.enemyoverride[1].origin);
            }
            self.ignoreall = 1;
            goalpos = self.enemyoverride[0];
            if (isdefined(level.var_b9b31fde)) {
                goalpos = self [[ level.var_b9b31fde ]]();
            }
            self setgoal(goalpos);
        } else if (isdefined(self.favoriteenemy)) {
            self.ignoreall = 0;
            if (isdefined(level.enemy_location_override_func)) {
                goalpos = [[ level.enemy_location_override_func ]](self, self.favoriteenemy);
                if (isdefined(goalpos)) {
                    self setgoal(goalpos);
                } else {
                    self zm_behavior::zombieupdategoal();
                }
            } else if (isdefined(self.is_rat_test) && self.is_rat_test) {
            } else if (zm_behavior::zombieshouldmoveawaycondition(self)) {
                wait(0.05);
                continue;
            } else if (isdefined(self.favoriteenemy.last_valid_position)) {
                self setgoal(self.favoriteenemy.last_valid_position);
            }
            if (!isdefined(level.var_46a42812)) {
                distsq = distancesquared(self.origin, self.favoriteenemy.origin);
                if (distsq > 10240000) {
                    wait(2 + randomfloat(1));
                } else if (distsq > 4840000) {
                    wait(1 + randomfloat(0.5));
                } else if (distsq > 1440000) {
                    wait(0.5 + randomfloat(0.5));
                }
            }
        }
        if (isdefined(level.var_5d228076)) {
            self [[ level.var_5332f22b ]]();
        }
    }
}

// Namespace zm_spawner
// Params 1, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_c0464b42
// Checksum 0xa0ab68bb, Offset: 0x91f8
// Size: 0x52
function zombie_history(msg) {
    /#
        if (!isdefined(self.zombie_history) || 32 <= self.zombie_history.size) {
            self.zombie_history = [];
        }
        self.zombie_history[self.zombie_history.size] = msg;
    #/
}

// Namespace zm_spawner
// Params 0, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_50b1a577
// Checksum 0x7b9ee757, Offset: 0x9258
// Size: 0x728
function do_zombie_spawn() {
    self endon(#"death");
    spots = [];
    if (isdefined(self._rise_spot)) {
        spot = self._rise_spot;
        self thread do_zombie_rise(spot);
        return;
    }
    if (isdefined(level.use_multiple_spawns) && level.use_multiple_spawns && isdefined(self.script_int)) {
        foreach (loc in level.zm_loc_types["zombie_location"]) {
            if (!(isdefined(level.spawner_int) && level.spawner_int == self.script_int) && !(isdefined(loc.script_int) || isdefined(level.zones[loc.zone_name].script_int))) {
                continue;
            }
            if (isdefined(loc.script_int) && loc.script_int != self.script_int) {
                continue;
            } else if (isdefined(level.zones[loc.zone_name].script_int) && level.zones[loc.zone_name].script_int != self.script_int) {
                continue;
            }
            spots[spots.size] = loc;
        }
    } else {
        spots = level.zm_loc_types["zombie_location"];
    }
    if (getdvarint("scr_zombie_spawn_in_view")) {
        player = getplayers()[0];
        spots = [];
        max_dot = 0;
        look_loc = undefined;
        foreach (loc in level.zm_loc_types["zombie_location"]) {
            player_vec = vectornormalize(anglestoforward(player getplayerangles()));
            player_vec_2d = (player_vec[0], player_vec[1], 0);
            player_spawn = vectornormalize(loc.origin - player.origin);
            player_spawn_2d = (player_spawn[0], player_spawn[1], 0);
            dot = vectordot(player_vec_2d, player_spawn_2d);
            dist = distance(loc.origin, player.origin);
            if (dot > 0.707 && dist <= getdvarint("scr_zombie_spawn_in_view_dist")) {
                if (dot > max_dot) {
                    look_loc = loc;
                    max_dot = dot;
                }
                /#
                    debugstar(loc.origin, 1000, (1, 1, 1));
                #/
            }
        }
        if (isdefined(look_loc)) {
            spots[spots.size] = look_loc;
            /#
                debugstar(look_loc.origin, 1000, (0, 1, 0));
            #/
        }
        if (spots.size <= 0) {
            spots[spots.size] = level.zm_loc_types["zombie_location"][0];
            iprintln("no spawner in view");
        }
    }
    assert(spots.size > 0, "stand");
    if (isdefined(level.zm_custom_spawn_location_selection)) {
        spot = [[ level.zm_custom_spawn_location_selection ]](spots);
    } else {
        spot = array::random(spots);
    }
    self.spawn_point = spot;
    /#
        if (getdvarint("stand")) {
            level.zones[spot.zone_name].total_spawn_count++;
            level.zones[spot.zone_name].round_spawn_count++;
            self.zone_spawned_from = spot.zone_name;
            self thread draw_zone_spawned_from();
        }
    #/
    /#
        if (isdefined(level.toggle_show_spawn_locations) && level.toggle_show_spawn_locations) {
            debugstar(spot.origin, getdvarint("stand"), (0, 1, 0));
            host_player = util::gethostplayer();
            distance = distance(spot.origin, host_player.origin);
            iprintln("stand" + distance / 12 + "stand");
        }
    #/
    self thread [[ level.move_spawn_func ]](spot);
}

/#

    // Namespace zm_spawner
    // Params 0, eflags: 0x1 linked
    // namespace_ae969b2b<file_0>::function_c77f0242
    // Checksum 0xcf13338c, Offset: 0x9988
    // Size: 0x58
    function draw_zone_spawned_from() {
        self endon(#"death");
        while (true) {
            print3d(self.origin + (0, 0, 64), self.zone_spawned_from, (1, 1, 1));
            wait(0.05);
        }
    }

#/

// Namespace zm_spawner
// Params 1, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_7b062181
// Checksum 0x253e8d86, Offset: 0x99e8
// Size: 0x446
function do_zombie_rise(spot) {
    self endon(#"death");
    self.in_the_ground = 1;
    if (isdefined(self.anchor)) {
        self.anchor delete();
    }
    self.anchor = spawn("script_origin", self.origin);
    self.anchor.angles = self.angles;
    self linkto(self.anchor);
    if (!isdefined(spot.angles)) {
        spot.angles = (0, 0, 0);
    }
    anim_org = spot.origin;
    anim_ang = spot.angles;
    anim_org += (0, 0, 0);
    self ghost();
    self.anchor moveto(anim_org, 0.05);
    self.anchor waittill(#"movedone");
    target_org = zombie_utility::get_desired_origin();
    if (isdefined(target_org)) {
        anim_ang = vectortoangles(target_org - self.origin);
        self.anchor rotateto((0, anim_ang[1], 0), 0.05);
        self.anchor waittill(#"rotatedone");
    }
    self unlink();
    if (isdefined(self.anchor)) {
        self.anchor delete();
    }
    self thread zombie_utility::hide_pop();
    level thread zombie_utility::zombie_rise_death(self, spot);
    spot thread zombie_rise_fx(self);
    substate = 0;
    if (self.zombie_move_speed == "walk") {
        substate = randomint(2);
    } else if (self.zombie_move_speed == "run") {
        substate = 2;
    } else if (self.zombie_move_speed == "sprint") {
        substate = 3;
    }
    self orientmode("face default");
    if (isdefined(level.custom_riseanim)) {
        self animscripted("rise_anim", self.origin, spot.angles, level.custom_riseanim);
    } else if (isdefined(level.var_8a723769)) {
        self [[ level.var_8a723769 ]](spot);
    } else {
        self animscripted("rise_anim", self.origin, spot.angles, "ai_zombie_traverse_ground_climbout_fast");
    }
    self zombie_shared::donotetracks("rise_anim", &zombie_utility::handle_rise_notetracks, spot);
    self notify(#"rise_anim_finished");
    spot notify(#"stop_zombie_rise_fx");
    self.in_the_ground = 0;
    self notify(#"risen", spot.script_string);
}

// Namespace zm_spawner
// Params 1, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_4f66586
// Checksum 0xc74592ea, Offset: 0x9e38
// Size: 0xb2
function zombie_rise_fx(zombie) {
    if (!(isdefined(level.riser_fx_on_client) && level.riser_fx_on_client)) {
        self thread zombie_rise_dust_fx(zombie);
        self thread zombie_rise_burst_fx(zombie);
    } else {
        self thread zombie_rise_burst_fx(zombie);
    }
    zombie endon(#"death");
    self endon(#"stop_zombie_rise_fx");
    wait(1);
    if (zombie.zombie_move_speed != "sprint") {
        wait(1);
    }
}

// Namespace zm_spawner
// Params 1, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_e3071dfb
// Checksum 0x1700ee43, Offset: 0x9ef8
// Size: 0x22c
function zombie_rise_burst_fx(zombie) {
    self endon(#"stop_zombie_rise_fx");
    self endon(#"rise_anim_finished");
    if (isdefined(self.script_parameters) && self.script_parameters == "in_water" && !(isdefined(level._no_water_risers) && level._no_water_risers)) {
        zombie clientfield::set("zombie_riser_fx_water", 1);
        return;
    }
    if (isdefined(level._foliage_risers) && isdefined(self.script_parameters) && self.script_parameters == "in_foliage" && level._foliage_risers) {
        zombie clientfield::set("zombie_riser_fx_foliage", 1);
        return;
    }
    if (isdefined(self.script_parameters) && self.script_parameters == "in_snow") {
        zombie clientfield::set("zombie_riser_fx", 1);
        return;
    }
    if (isdefined(zombie.zone_name) && isdefined(level.zones[zombie.zone_name])) {
        low_g_zones = getentarray(zombie.zone_name, "targetname");
        if (isdefined(low_g_zones[0].script_string) && low_g_zones[0].script_string == "lowgravity") {
            zombie clientfield::set("zombie_riser_fx_lowg", 1);
        } else {
            zombie clientfield::set("zombie_riser_fx", 1);
        }
        return;
    }
    zombie clientfield::set("zombie_riser_fx", 1);
}

// Namespace zm_spawner
// Params 1, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_af6ed0e9
// Checksum 0xef582f9c, Offset: 0xa130
// Size: 0x256
function zombie_rise_dust_fx(zombie) {
    dust_tag = "J_SpineUpper";
    self endon(#"hash_f4618b56");
    self thread function_f4618b56(zombie);
    wait(2);
    dust_time = 5.5;
    dust_interval = 0.3;
    if (isdefined(self.script_parameters) && self.script_parameters == "in_water") {
        for (t = 0; t < dust_time; t += dust_interval) {
            playfxontag(level._effect["rise_dust_water"], zombie, dust_tag);
            wait(dust_interval);
        }
        return;
    }
    if (isdefined(self.script_parameters) && self.script_parameters == "in_snow") {
        for (t = 0; t < dust_time; t += dust_interval) {
            playfxontag(level._effect["rise_dust_snow"], zombie, dust_tag);
            wait(dust_interval);
        }
        return;
    }
    if (isdefined(self.script_parameters) && self.script_parameters == "in_foliage") {
        for (t = 0; t < dust_time; t += dust_interval) {
            playfxontag(level._effect["rise_dust_foliage"], zombie, dust_tag);
            wait(dust_interval);
        }
        return;
    }
    for (t = 0; t < dust_time; t += dust_interval) {
        playfxontag(level._effect["rise_dust"], zombie, dust_tag);
        wait(dust_interval);
    }
}

// Namespace zm_spawner
// Params 1, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_f4618b56
// Checksum 0xbba038df, Offset: 0xa390
// Size: 0x26
function function_f4618b56(zombie) {
    zombie waittill(#"death");
    self notify(#"hash_f4618b56");
}

// Namespace zm_spawner
// Params 0, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_2777b1df
// Checksum 0x65d65615, Offset: 0xa3c0
// Size: 0xc4
function zombie_tesla_head_gib() {
    self endon(#"death");
    if (self.animname == "quad_zombie") {
        return;
    }
    if (randomint(100) < level.zombie_vars["tesla_head_gib_chance"]) {
        wait(randomfloatrange(0.53, 1));
        self zombie_utility::zombie_head_gib();
        return;
    }
    zm_net::network_safe_play_fx_on_tag("tesla_death_fx", 2, level._effect["tesla_shock_eyes"], self, "J_Eyeball_LE");
}

// Namespace zm_spawner
// Params 0, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_5f6586cc
// Checksum 0x30bf2f57, Offset: 0xa490
// Size: 0x1b8
function play_ambient_zombie_vocals() {
    self endon(#"death");
    while (true) {
        type = "ambient";
        float = 4;
        if (isdefined(self.zombie_move_speed)) {
            switch (self.zombie_move_speed) {
            case 157:
                type = "ambient";
                float = 4;
                break;
            case 158:
                type = "sprint";
                float = 4;
                break;
            case 159:
                type = "sprint";
                float = 4;
                break;
            }
        }
        if (self.animname == "zombie" && self.missinglegs) {
            type = "crawler";
        } else if (self.animname == "thief_zombie" || self.animname == "leaper_zombie") {
            float = 1.2;
        } else if (self.voiceprefix == "keeper") {
            float = 1.2;
        }
        name = self.animname;
        if (isdefined(self.sndname)) {
            name = self.sndname;
        }
        self notify(#"bhtn_action_notify", type);
        wait(randomfloatrange(1, float));
    }
}

// Namespace zm_spawner
// Params 0, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_1bfa6f52
// Checksum 0xc5fbc20f, Offset: 0xa650
// Size: 0xb4
function zombie_complete_emerging_into_playable_area() {
    self.should_turn = 0;
    self.completed_emerging_into_playable_area = 1;
    self.no_powerups = 0;
    self notify(#"completed_emerging_into_playable_area");
    if (isdefined(self.backedupgoal)) {
        self setgoal(self.backedupgoal);
        self.backedupgoal = undefined;
    }
    self thread function_60389561();
    self thread function_525366e2();
    self thread zm::update_zone_name();
}

// Namespace zm_spawner
// Params 0, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_60389561
// Checksum 0x33278b9c, Offset: 0xa710
// Size: 0x3c
function function_60389561() {
    self endon(#"death");
    wait(1.5);
    if (!isdefined(self)) {
        return;
    }
    self setfreecameralockonallowed(1);
}

// Namespace zm_spawner
// Params 0, eflags: 0x1 linked
// namespace_ae969b2b<file_0>::function_525366e2
// Checksum 0x92e4f341, Offset: 0xa758
// Size: 0x34
function function_525366e2() {
    self endon(#"death");
    wait(5);
    if (!isdefined(self)) {
        return;
    }
    self function_1762804b(1);
}

