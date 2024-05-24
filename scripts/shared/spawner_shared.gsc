#using scripts/shared/util_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/system_shared;
#using scripts/shared/serverfaceanim_shared;
#using scripts/shared/gameskill_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#namespace spawner;

// Namespace spawner
// Params 0, eflags: 0x2
// Checksum 0x3503196b, Offset: 0x418
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("spawner", &__init__, &__main__, undefined);
}

// Namespace spawner
// Params 0, eflags: 0x1 linked
// Checksum 0x650b8de, Offset: 0x460
// Size: 0x2b4
function __init__() {
    if (getdvarstring("noai") == "") {
        setdvar("noai", "off");
    }
    level.var_a26bb201 = 0;
    level._ai_group = [];
    level.var_aab66249 = 0;
    level.var_cdd4501c = 0;
    level.missionfailed = 0;
    level.gather_delay = [];
    level.smoke_thrown = [];
    level.deathflags = [];
    level.spawner_number = 0;
    level.go_to_node_arrays = [];
    level.var_62f0fe0f = 0;
    level.var_8cf3d08d = randomintrange(1, 4);
    level.portable_mg_gun_tag = "J_Shoulder_RI";
    level.var_374e1364 = 1024;
    level.global_spawn_timer = 0;
    level.global_spawn_count = 0;
    if (!isdefined(level.var_d9adcaa0)) {
        level.var_d9adcaa0 = 11;
    }
    level.ai_classname_in_level = [];
    spawners = getspawnerarray();
    for (i = 0; i < spawners.size; i++) {
        spawners[i] thread spawn_prethink();
    }
    thread process_deathflags();
    function_56e4fd0a(array("rpg"));
    function_e13533be();
    level thread function_a8d978f5();
    level.ai = [];
    add_global_spawn_function("axis", &global_ai_array);
    add_global_spawn_function("allies", &global_ai_array);
    add_global_spawn_function("team3", &global_ai_array);
    level thread function_dfee667c();
}

// Namespace spawner
// Params 0, eflags: 0x1 linked
// Checksum 0xe7567a93, Offset: 0x720
// Size: 0x114
function __main__() {
    waittillframeend();
    ai = getaispeciesarray("all");
    array::thread_all(ai, &living_ai_prethink);
    foreach (ai_guy in ai) {
        if (isalive(ai_guy)) {
            ai_guy.var_2b9436f7 = &function_b218c24b;
            ai_guy thread spawn_think();
        }
    }
    level thread spawn_throttle_reset();
}

// Namespace spawner
// Params 0, eflags: 0x1 linked
// Checksum 0x4ce4eea3, Offset: 0x840
// Size: 0x120
function function_dfee667c() {
    level.var_ca441239 = [];
    var_5f355738 = getentarray("trigger_navmesh", "classname");
    if (!var_5f355738.size) {
        return;
    }
    level.navmesh_zones = [];
    foreach (trig in var_5f355738) {
        level.navmesh_zones[trig.targetname] = 0;
    }
    while (true) {
        updatenavtriggers();
        level util::waittill_notify_or_timeout("update_nav_triggers", 1);
    }
}

// Namespace spawner
// Params 0, eflags: 0x1 linked
// Checksum 0xa90ea074, Offset: 0x968
// Size: 0x2b4
function global_ai_array() {
    if (!isdefined(level.ai[self.team])) {
        level.ai[self.team] = [];
    } else if (!isarray(level.ai[self.team])) {
        level.ai[self.team] = array(level.ai[self.team]);
    }
    level.ai[self.team][level.ai[self.team].size] = self;
    self waittill(#"death");
    if (isdefined(self)) {
        if (isdefined(level.ai) && isdefined(level.ai[self.team]) && isinarray(level.ai[self.team], self)) {
            arrayremovevalue(level.ai[self.team], self);
        } else {
            foreach (aiarray in level.ai) {
                if (isinarray(aiarray, self)) {
                    arrayremovevalue(aiarray, self);
                    break;
                }
            }
        }
        return;
    }
    foreach (array in level.ai) {
        for (i = array.size - 1; i >= 0; i--) {
            if (!isdefined(array[i])) {
                arrayremoveindex(array, i);
            }
        }
    }
}

// Namespace spawner
// Params 0, eflags: 0x1 linked
// Checksum 0xab53b5a5, Offset: 0xc28
// Size: 0x3c
function spawn_throttle_reset() {
    while (true) {
        util::wait_network_frame();
        util::wait_network_frame();
        level.global_spawn_count = 0;
    }
}

// Namespace spawner
// Params 1, eflags: 0x1 linked
// Checksum 0xee27373e, Offset: 0xc70
// Size: 0x48
function global_spawn_throttle(n_count_per_network_frame) {
    if (!(isdefined(level.first_frame) && level.first_frame)) {
        while (level.global_spawn_count >= n_count_per_network_frame) {
            wait(0.05);
        }
        level.global_spawn_count++;
    }
}

// Namespace spawner
// Params 0, eflags: 0x1 linked
// Checksum 0x1787f7b3, Offset: 0xcc0
// Size: 0x4
function function_b218c24b() {
    
}

// Namespace spawner
// Params 0, eflags: 0x1 linked
// Checksum 0xc4f58ea2, Offset: 0xcd0
// Size: 0xec
function function_e13533be() {
    volumes = getentarray("info_volume", "classname");
    level.deathchain_goalvolume = [];
    level.goalvolumes = [];
    for (i = 0; i < volumes.size; i++) {
        volume = volumes[i];
        if (isdefined(volume.script_deathchain)) {
            level.deathchain_goalvolume[volume.script_deathchain] = volume;
        }
        if (isdefined(volume.script_goalvolume)) {
            level.goalvolumes[volume.script_goalvolume] = volume;
        }
    }
}

// Namespace spawner
// Params 1, eflags: 0x1 linked
// Checksum 0x3467519c, Offset: 0xdc8
// Size: 0x10e
function function_56e4fd0a(weapon_names) {
    level.var_54fc8b53 = getarraykeys(level.ai_classname_in_level);
    for (i = 0; i < level.var_54fc8b53.size; i++) {
        if (weapon_names.size <= 0) {
            break;
        }
        for (j = 0; j < weapon_names.size; j++) {
            weaponname = weapon_names[j];
            if (!issubstr(tolower(level.var_54fc8b53[i]), weaponname)) {
                continue;
            }
            arrayremovevalue(weapon_names, weaponname);
            break;
        }
    }
    level.var_54fc8b53 = undefined;
}

// Namespace spawner
// Params 0, eflags: 0x1 linked
// Checksum 0x3287c083, Offset: 0xee0
// Size: 0xce
function process_deathflags() {
    keys = getarraykeys(level.deathflags);
    level.deathflags = [];
    for (i = 0; i < keys.size; i++) {
        deathflag = keys[i];
        level.deathflags[deathflag] = [];
        level.deathflags[deathflag]["ai"] = [];
        if (!isdefined(level.flag[deathflag])) {
            level flag::init(deathflag);
        }
    }
}

// Namespace spawner
// Params 0, eflags: 0x0
// Checksum 0xea2265f5, Offset: 0xfb8
// Size: 0x1c
function spawn_guys_until_death_or_no_count() {
    self endon(#"death");
    self waittill(#"hash_b831ac08");
}

// Namespace spawner
// Params 1, eflags: 0x0
// Checksum 0xd26305c6, Offset: 0xfe0
// Size: 0x7c
function flood_spawner_scripted(spawners) {
    /#
        assert(isdefined(spawners) && spawners.size, "team3");
    #/
    array::thread_all(spawners, &flood_spawner_init);
    array::thread_all(spawners, &flood_spawner_think);
}

// Namespace spawner
// Params 1, eflags: 0x1 linked
// Checksum 0x58c09da9, Offset: 0x1068
// Size: 0x3c
function reincrement_count_if_deleted(spawner) {
    spawner endon(#"death");
    self waittill(#"death");
    if (!isdefined(self)) {
        spawner.count++;
    }
}

// Namespace spawner
// Params 1, eflags: 0x1 linked
// Checksum 0xf80ab128, Offset: 0x10b0
// Size: 0x64
function kill_trigger(trigger) {
    if (!isdefined(trigger)) {
        return;
    }
    if (isdefined(trigger.targetname) && trigger.targetname != "flood_spawner") {
        return;
    }
    trigger delete();
}

// Namespace spawner
// Params 0, eflags: 0x1 linked
// Checksum 0x1231d3f3, Offset: 0x1120
// Size: 0x1c
function waittilldeathorpaindeath() {
    self endon(#"death");
    self waittill(#"pain_death");
}

// Namespace spawner
// Params 0, eflags: 0x0
// Checksum 0x8d189b6e, Offset: 0x1148
// Size: 0x15c
function function_e9221084() {
    team = self.team;
    waittilldeathorpaindeath();
    if (!isdefined(self)) {
        return;
    }
    if (self.grenadeammo <= 0) {
        return;
    }
    if (isdefined(self.dropweapon) && !self.dropweapon) {
        return;
    }
    if (!isdefined(level.nextgrenadedrop)) {
        level.nextgrenadedrop = randomint(3);
    }
    level.nextgrenadedrop--;
    if (level.nextgrenadedrop > 0) {
        return;
    }
    level.nextgrenadedrop = 2 + randomint(2);
    function_938ef3c2(self.origin + (randomint(25) - 12, randomint(25) - 12, 2) + (0, 0, 42), (0, randomint(360), 0), self.team);
}

// Namespace spawner
// Params 3, eflags: 0x1 linked
// Checksum 0x6f787029, Offset: 0x12b0
// Size: 0x174
function function_938ef3c2(origin, angles, team) {
    if (!isdefined(level.grenade_cache) || !isdefined(level.grenade_cache[team])) {
        level.grenade_cache_index[team] = 0;
        level.grenade_cache[team] = [];
    }
    index = level.grenade_cache_index[team];
    grenade = level.grenade_cache[team][index];
    if (isdefined(grenade)) {
        grenade delete();
    }
    count = self.grenadeammo;
    grenade = sys::spawn("weapon_" + self.grenadeweapon.name + level.game_mode_suffix, origin);
    level.grenade_cache[team][index] = grenade;
    level.grenade_cache_index[team] = (index + 1) % 16;
    grenade.angles = angles;
    grenade.count = count;
}

// Namespace spawner
// Params 0, eflags: 0x1 linked
// Checksum 0xb9ee2ecc, Offset: 0x1430
// Size: 0x124
function spawn_prethink() {
    /#
        assert(self != level);
    #/
    level.ai_classname_in_level[self.classname] = 1;
    /#
        if (getdvarstring("team3") != "team3") {
            self.count = 0;
            return;
        }
    #/
    if (isdefined(self.script_aigroup)) {
        aigroup_init(self.script_aigroup, self);
    }
    if (isdefined(self.script_delete)) {
        array_size = 0;
        if (isdefined(level._ai_delete)) {
            if (isdefined(level._ai_delete[self.script_delete])) {
                array_size = level._ai_delete[self.script_delete].size;
            }
        }
        level._ai_delete[self.script_delete][array_size] = self;
    }
    if (isdefined(self.target)) {
        crawl_through_targets_to_init_flags();
    }
}

// Namespace spawner
// Params 0, eflags: 0x1 linked
// Checksum 0xd3e9150d, Offset: 0x1560
// Size: 0x5e
function function_a612833a() {
    level notify(#"hash_dfee667c");
    while (isalive(self)) {
        self util::waittill_either("death", "goal_changed");
        level notify(#"hash_dfee667c");
    }
}

// Namespace spawner
// Params 1, eflags: 0x1 linked
// Checksum 0x85444f87, Offset: 0x15c8
// Size: 0x266
function spawn_think(spawner) {
    self endon(#"death");
    if (isdefined(self.spawn_think_thread_active)) {
        return;
    }
    self.spawn_think_thread_active = 1;
    self.spawner = spawner;
    /#
        assert(isactor(self) || isvehicle(self), "spawner::spawn_think" + "team3");
    #/
    if (!isvehicle(self)) {
        if (!isalive(self)) {
            return;
        }
        self.maxhealth = self.health;
        self thread function_a612833a();
    }
    self.script_animname = undefined;
    if (isdefined(self.script_aigroup)) {
        level flag::set(self.script_aigroup + "_spawning");
        self thread aigroup_think(level._ai_group[self.script_aigroup]);
    }
    if (isdefined(spawner) && isdefined(spawner.script_dropammo)) {
        self.disableammodrop = !spawner.script_dropammo;
    }
    if (isdefined(spawner) && isdefined(spawner.spawn_funcs)) {
        self.spawn_funcs = spawner.spawn_funcs;
    }
    if (isai(self)) {
        spawn_think_action(spawner);
        /#
            assert(isalive(self));
        #/
        /#
            assert(isdefined(self.team));
        #/
    }
    self thread run_spawn_functions();
    self.finished_spawning = 1;
    self notify(#"hash_f42b7e06");
}

// Namespace spawner
// Params 0, eflags: 0x1 linked
// Checksum 0x752232f9, Offset: 0x1838
// Size: 0x28e
function run_spawn_functions() {
    self endon(#"death");
    if (!isdefined(level.spawn_funcs)) {
        return;
    }
    if (isdefined(self.archetype) && isdefined(level.spawn_funcs[self.archetype])) {
        for (i = 0; i < level.spawn_funcs[self.archetype].size; i++) {
            func = level.spawn_funcs[self.archetype][i];
            util::single_thread(self, func["function"], func["param1"], func["param2"], func["param3"], func["param4"], func["param5"]);
        }
    }
    waittillframeend();
    callback::callback(#"hash_f96ca9bc");
    if (isdefined(level.spawn_funcs[self.team])) {
        for (i = 0; i < level.spawn_funcs[self.team].size; i++) {
            func = level.spawn_funcs[self.team][i];
            util::single_thread(self, func["function"], func["param1"], func["param2"], func["param3"], func["param4"], func["param5"]);
        }
    }
    if (isdefined(self.spawn_funcs)) {
        for (i = 0; i < self.spawn_funcs.size; i++) {
            func = self.spawn_funcs[i];
            util::single_thread(self, func["function"], func["param1"], func["param2"], func["param3"], func["param4"], func["param5"]);
        }
        /#
            return;
        #/
        self.spawn_funcs = undefined;
    }
}

// Namespace spawner
// Params 0, eflags: 0x1 linked
// Checksum 0xfe06d25f, Offset: 0x1ad0
// Size: 0x44
function living_ai_prethink() {
    if (isdefined(self.script_deathflag)) {
        level.deathflags[self.script_deathflag] = 1;
    }
    if (isdefined(self.target)) {
        crawl_through_targets_to_init_flags();
    }
}

// Namespace spawner
// Params 0, eflags: 0x1 linked
// Checksum 0xb967abec, Offset: 0x1b20
// Size: 0xae
function crawl_through_targets_to_init_flags() {
    array = get_node_funcs_based_on_target();
    if (isdefined(array)) {
        targets = array["node"];
        get_func = array["get_target_func"];
        for (i = 0; i < targets.size; i++) {
            crawl_target_and_init_flags(targets[i], get_func);
        }
    }
}

// Namespace spawner
// Params 0, eflags: 0x1 linked
// Checksum 0xb7fb3a9b, Offset: 0x1bd8
// Size: 0xe
function remove_spawner_values() {
    self.spawner_number = undefined;
}

// Namespace spawner
// Params 1, eflags: 0x1 linked
// Checksum 0x6caf08f8, Offset: 0x1bf0
// Size: 0x680
function spawn_think_action(spawner) {
    remove_spawner_values();
    if (isdefined(level._use_faceanim) && level._use_faceanim) {
        self thread serverfaceanim::init_serverfaceanim();
    }
    if (isdefined(spawner)) {
        if (isdefined(spawner.targetname) && !isdefined(self.targetname)) {
            self.targetname = spawner.targetname + "_ai";
        }
    }
    if (isdefined(spawner) && isdefined(spawner.script_animname)) {
        self.animname = spawner.script_animname;
    } else if (isdefined(self.script_animname)) {
        self.animname = self.script_animname;
    }
    /#
        thread show_bad_path();
    #/
    if (isdefined(self.script_forcecolor)) {
        colors::set_force_color(self.script_forcecolor);
        if ((!isdefined(self.var_1b15c72f) || self.var_1b15c72f < 1) && !isdefined(level.var_124e4a56)) {
            self thread replace_on_death();
        }
    }
    if (isdefined(self.script_moveoverride) && self.script_moveoverride == 1) {
        override = 1;
    } else {
        override = 0;
    }
    self.var_b327e32a = issubstr(self.classname, "mgportable");
    gameskill::grenadeawareness();
    if (isdefined(self.script_ignoreme)) {
        /#
            assert(self.script_ignoreme == 1, "team3");
        #/
        self.ignoreme = 1;
    }
    if (isdefined(self.var_665ba85b)) {
        /#
            assert(self.var_665ba85b == 1, "team3");
        #/
    }
    if (isdefined(self.script_ignoreall)) {
        /#
            assert(self.script_ignoreall == 1, "team3");
        #/
        self.ignoreall = 1;
    }
    if (isdefined(self.script_sightrange)) {
        self.maxsightdistsqrd = self.script_sightrange;
    } else if (self.weaponclass === "gas") {
        self.maxsightdistsqrd = 1048576;
    }
    if (self.team != "axis") {
        if (isdefined(self.script_followmin)) {
            self.followmin = self.script_followmin;
        }
        if (isdefined(self.script_followmax)) {
            self.followmax = self.script_followmax;
        }
    }
    if (self.team == "axis") {
        if (isdefined(self.type) && self.type == "human") {
        }
    }
    if (isdefined(self.script_fightdist)) {
        self.pathenemyfightdist = self.script_fightdist;
    }
    if (isdefined(self.script_maxdist)) {
        self.pathenemylookahead = self.script_maxdist;
    }
    if (isdefined(self.script_longdeath)) {
        /#
            assert(!self.script_longdeath, "team3" + self.export);
        #/
        self.a.disablelongdeath = 1;
        /#
            assert(self.team != "team3", "team3" + self.export);
        #/
    }
    if (isdefined(self.script_grenades)) {
        self.grenadeammo = self.script_grenades;
    }
    if (isdefined(self.script_pacifist)) {
        self.pacifist = 1;
    }
    if (isdefined(self.script_startinghealth)) {
        self.health = self.script_startinghealth;
    }
    if (isdefined(self.script_allowdeath)) {
        self.allowdeath = self.script_allowdeath;
    }
    if (isdefined(self.script_forcegib)) {
        self.force_gib = 1;
    }
    if (isdefined(self.script_lights_on)) {
        self.var_c8655b7 = 1;
    }
    if (isdefined(self.script_stealth)) {
    }
    if (isdefined(self.script_patroller)) {
        return;
    }
    if (isdefined(self.var_b9d825b0) && self.var_b9d825b0) {
        return;
    }
    if (isdefined(self.used_an_mg42)) {
        return;
    }
    if (override) {
        self thread set_goalradius_based_on_settings();
        self setgoal(self.origin);
        return;
    }
    if (isdefined(level.var_d28aaa95) && level.var_d28aaa95) {
        return;
    }
    if (isdefined(self.vehicleclass) && self.vehicleclass == "artillery") {
        return;
    }
    if (isdefined(self.target)) {
        e_goal = getent(self.target, "targetname");
        if (isdefined(e_goal)) {
            self setgoal(e_goal);
        } else {
            self thread go_to_node();
        }
    } else {
        self thread set_goalradius_based_on_settings();
        if (isdefined(self.var_81ec425a)) {
            self thread go_to_spawner_target(strtok(self.var_81ec425a, " "));
        }
    }
    if (isdefined(self.script_goalvolume)) {
        self thread set_goal_volume();
    }
    if (isdefined(self.var_d66f2978)) {
        self.turnrate = self.var_d66f2978;
    }
}

// Namespace spawner
// Params 0, eflags: 0x1 linked
// Checksum 0x5045471c, Offset: 0x2278
// Size: 0x28c
function set_goal_volume() {
    self endon(#"death");
    waittillframeend();
    volume = level.goalvolumes[self.script_goalvolume];
    if (!isdefined(volume)) {
        return;
    }
    if (isdefined(volume.target)) {
        node = getnode(volume.target, "targetname");
        ent = getent(volume.target, "targetname");
        struct = struct::get(volume.target, "targetname");
        pos = undefined;
        if (isdefined(node)) {
            pos = node;
            self setgoal(pos);
        } else if (isdefined(ent)) {
            pos = ent;
            self setgoal(pos.origin);
        } else if (isdefined(struct)) {
            pos = struct;
            self setgoal(pos.origin);
        }
        if (isdefined(pos.radius) && pos.radius != 0) {
            self.goalradius = pos.radius;
        }
        if (isdefined(pos.goalheight) && pos.goalheight != 0) {
            self.goalheight = pos.goalheight;
        }
    }
    if (isdefined(self.target)) {
        self setgoal(volume);
        return;
    }
    if (isdefined(self.var_81ec425a)) {
        self waittill(#"hash_aadb7d08");
        self setgoal(volume);
        return;
    }
    self setgoal(volume);
}

// Namespace spawner
// Params 1, eflags: 0x1 linked
// Checksum 0x5fc57d3f, Offset: 0x2510
// Size: 0x2a
function get_target_ents(target) {
    return getentarray(target, "targetname");
}

// Namespace spawner
// Params 1, eflags: 0x1 linked
// Checksum 0x3f161449, Offset: 0x2548
// Size: 0x2a
function get_target_nodes(target) {
    return getnodearray(target, "targetname");
}

// Namespace spawner
// Params 1, eflags: 0x1 linked
// Checksum 0x91273fa2, Offset: 0x2580
// Size: 0x2a
function get_target_structs(target) {
    return struct::get_array(target, "targetname");
}

// Namespace spawner
// Params 1, eflags: 0x1 linked
// Checksum 0xb485d7c8, Offset: 0x25b8
// Size: 0x32
function node_has_radius(node) {
    return isdefined(node.radius) && node.radius != 0;
}

// Namespace spawner
// Params 2, eflags: 0x0
// Checksum 0xd39d6c93, Offset: 0x25f8
// Size: 0x3c
function go_to_origin(node, optional_arrived_at_node_func) {
    self go_to_node(node, "origin", optional_arrived_at_node_func);
}

// Namespace spawner
// Params 2, eflags: 0x0
// Checksum 0x551db46d, Offset: 0x2640
// Size: 0x3c
function go_to_struct(node, optional_arrived_at_node_func) {
    self go_to_node(node, "struct", optional_arrived_at_node_func);
}

// Namespace spawner
// Params 3, eflags: 0x1 linked
// Checksum 0xabf37034, Offset: 0x2688
// Size: 0xd4
function go_to_node(node, goal_type, optional_arrived_at_node_func) {
    self endon(#"death");
    if (isdefined(self.used_an_mg42)) {
        return;
    }
    array = get_node_funcs_based_on_target(node, goal_type);
    if (!isdefined(array)) {
        self notify(#"reached_path_end");
        return;
    }
    if (!isdefined(optional_arrived_at_node_func)) {
        optional_arrived_at_node_func = &util::empty;
    }
    go_to_node_using_funcs(array["node"], array["get_target_func"], array["set_goal_func_quits"], optional_arrived_at_node_func);
}

// Namespace spawner
// Params 0, eflags: 0x1 linked
// Checksum 0x41860e1d, Offset: 0x2768
// Size: 0x8c
function function_a8d978f5() {
    allnodes = getallnodes();
    level.var_5c223930 = [];
    for (i = 0; i < allnodes.size; i++) {
        if (isdefined(allnodes[i].var_81ec425a)) {
            level.var_5c223930[level.var_5c223930.size] = allnodes[i];
        }
    }
}

// Namespace spawner
// Params 1, eflags: 0x1 linked
// Checksum 0xa7e1fe5b, Offset: 0x2800
// Size: 0x534
function go_to_spawner_target(var_bc8effff) {
    self endon(#"death");
    self notify(#"go_to_spawner_target");
    self endon(#"go_to_spawner_target");
    nodes = [];
    var_90798ce7 = [];
    var_c7b716f5 = 0;
    for (i = 0; i < var_bc8effff.size; i++) {
        target_nodes = function_105d04bc(var_bc8effff[i]);
        if (target_nodes.size > 0) {
            var_c7b716f5 = 1;
        }
        foreach (node in target_nodes) {
            if (isdefined(node.node_claimed) && (isnodeoccupied(node) || node.node_claimed)) {
                if (!isdefined(var_90798ce7)) {
                    var_90798ce7 = [];
                } else if (!isarray(var_90798ce7)) {
                    var_90798ce7 = array(var_90798ce7);
                }
                var_90798ce7[var_90798ce7.size] = node;
                continue;
            }
            if (isdefined(node.spawnflags) && (node.spawnflags & 512) == 512) {
                if (!isdefined(var_90798ce7)) {
                    var_90798ce7 = [];
                } else if (!isarray(var_90798ce7)) {
                    var_90798ce7 = array(var_90798ce7);
                }
                var_90798ce7[var_90798ce7.size] = node;
                continue;
            }
            if (!isdefined(nodes)) {
                nodes = [];
            } else if (!isarray(nodes)) {
                nodes = array(nodes);
            }
            nodes[nodes.size] = node;
        }
    }
    if (nodes.size == 0) {
        while (nodes.size == 0) {
            foreach (node in var_90798ce7) {
                if (!isnodeoccupied(node) && !(isdefined(node.node_claimed) && node.node_claimed) && !(isdefined(node.spawnflags) && (node.spawnflags & 512) == 512)) {
                    if (!isdefined(nodes)) {
                        nodes = [];
                    } else if (!isarray(nodes)) {
                        nodes = array(nodes);
                    }
                    nodes[nodes.size] = node;
                    break;
                }
            }
            wait(0.2);
        }
    }
    /#
        assert(var_c7b716f5, "team3");
    #/
    goal = undefined;
    if (nodes.size > 0) {
        goal = array::random(nodes);
    }
    if (isdefined(goal)) {
        if (isdefined(self.script_radius)) {
            self.goalradius = self.script_radius;
        } else {
            self.goalradius = 400;
        }
        goal.node_claimed = 1;
        self setgoal(goal);
        self notify(#"hash_aadb7d08");
        self thread function_4c9e0c2e(goal);
        self waittill(#"goal");
    }
    self set_goalradius_based_on_settings(goal);
}

// Namespace spawner
// Params 1, eflags: 0x1 linked
// Checksum 0xe4a910b5, Offset: 0x2d40
// Size: 0x42
function function_4c9e0c2e(node) {
    self util::waittill_any("death", "goal_changed");
    node.node_claimed = undefined;
}

// Namespace spawner
// Params 1, eflags: 0x1 linked
// Checksum 0x9551d670, Offset: 0x2d90
// Size: 0xf6
function function_105d04bc(group) {
    if (group == "") {
        return [];
    }
    nodes = [];
    for (i = 0; i < level.var_5c223930.size; i++) {
        groups = strtok(level.var_5c223930[i].var_81ec425a, " ");
        for (j = 0; j < groups.size; j++) {
            if (groups[j] == group) {
                nodes[nodes.size] = level.var_5c223930[i];
            }
        }
    }
    return nodes;
}

// Namespace spawner
// Params 1, eflags: 0x1 linked
// Checksum 0x7d2cbeb8, Offset: 0x2e90
// Size: 0x14a
function get_least_used_from_array(array) {
    /#
        assert(array.size > 0, "team3");
    #/
    if (array.size == 1) {
        return array[0];
    }
    targetname = array[0].targetname;
    if (!isdefined(level.go_to_node_arrays[targetname])) {
        level.go_to_node_arrays[targetname] = array;
    }
    array = level.go_to_node_arrays[targetname];
    first = array[0];
    newarray = [];
    for (i = 0; i < array.size - 1; i++) {
        newarray[i] = array[i + 1];
    }
    newarray[array.size - 1] = array[0];
    level.go_to_node_arrays[targetname] = newarray;
    return first;
}

// Namespace spawner
// Params 5, eflags: 0x1 linked
// Checksum 0x3c54a625, Offset: 0x2fe8
// Size: 0x49c
function go_to_node_using_funcs(node, get_target_func, set_goal_func_quits, optional_arrived_at_node_func, require_player_dist) {
    self endon(#"stop_going_to_node");
    self endon(#"death");
    for (;;) {
        node = get_least_used_from_array(node);
        player_wait_dist = require_player_dist;
        if (isdefined(node.script_requires_player)) {
            if (node.script_requires_player > 1) {
                player_wait_dist = node.script_requires_player;
            } else {
                player_wait_dist = 256;
            }
            node.script_requires_player = 0;
        }
        self set_goalradius_based_on_settings(node);
        if (isdefined(node.height)) {
            self.goalheight = node.height;
        }
        [[ set_goal_func_quits ]](node);
        self waittill(#"goal");
        [[ optional_arrived_at_node_func ]](node);
        if (isdefined(node.script_flag_set)) {
            level flag::set(node.script_flag_set);
        }
        if (isdefined(node.script_flag_clear)) {
            level flag::set(node.script_flag_clear);
        }
        if (isdefined(node.script_ent_flag_set)) {
            if (!self flag::exists(node.script_ent_flag_set)) {
                /#
                    assertmsg("team3" + node.script_ent_flag_set + "team3");
                #/
            }
            self flag::set(node.script_ent_flag_set);
        }
        if (isdefined(node.script_ent_flag_clear)) {
            if (!self flag::exists(node.script_ent_flag_clear)) {
                /#
                    assertmsg("team3" + node.script_ent_flag_clear + "team3");
                #/
            }
            self flag::clear(node.script_ent_flag_clear);
        }
        if (isdefined(node.script_flag_wait)) {
            level flag::wait_till(node.script_flag_wait);
        }
        while (isdefined(node.script_requires_player)) {
            node.script_requires_player = 0;
            if (self go_to_node_wait_for_player(node, get_target_func, player_wait_dist)) {
                node.script_requires_player = 1;
                node notify(#"script_requires_player");
                break;
            }
            wait(0.1);
        }
        if (isdefined(node.script_aigroup)) {
            waittill_ai_group_cleared(node.script_aigroup);
        }
        node util::script_delay();
        if (!isdefined(node.target)) {
            break;
        }
        nextnode_array = update_target_array(node.target);
        if (!nextnode_array.size) {
            break;
        }
        node = nextnode_array;
    }
    if (isdefined(self.arrived_at_end_node_func)) {
        [[ self.arrived_at_end_node_func ]](node);
    }
    self notify(#"reached_path_end");
    if (isdefined(self.delete_on_path_end)) {
        self delete();
    }
    self set_goalradius_based_on_settings(node);
}

// Namespace spawner
// Params 3, eflags: 0x1 linked
// Checksum 0xd2399195, Offset: 0x3490
// Size: 0x346
function go_to_node_wait_for_player(node, get_target_func, dist) {
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        player = players[i];
        if (distancesquared(player.origin, node.origin) < distancesquared(self.origin, node.origin)) {
            return true;
        }
    }
    vec = anglestoforward(self.angles);
    if (isdefined(node.target)) {
        temp = [[ get_target_func ]](node.target);
        if (temp.size == 1) {
            vec = vectornormalize(temp[0].origin - node.origin);
        } else if (isdefined(node.angles)) {
            vec = anglestoforward(node.angles);
        }
    } else if (isdefined(node.angles)) {
        vec = anglestoforward(node.angles);
    }
    vec2 = [];
    for (i = 0; i < players.size; i++) {
        player = players[i];
        vec2[vec2.size] = vectornormalize(player.origin - self.origin);
    }
    for (i = 0; i < vec2.size; i++) {
        value = vec2[i];
        if (vectordot(vec, value) > 0) {
            return true;
        }
    }
    dist2rd = dist * dist;
    for (i = 0; i < players.size; i++) {
        player = players[i];
        if (distancesquared(player.origin, self.origin) < dist2rd) {
            return true;
        }
    }
    return false;
}

// Namespace spawner
// Params 1, eflags: 0x1 linked
// Checksum 0xa1fd4d90, Offset: 0x37e0
// Size: 0x2c
function go_to_node_set_goal_pos(ent) {
    self setgoal(ent.origin);
}

// Namespace spawner
// Params 1, eflags: 0x1 linked
// Checksum 0xac1e735, Offset: 0x3818
// Size: 0x24
function go_to_node_set_goal_node(node) {
    self setgoal(node);
}

// Namespace spawner
// Params 1, eflags: 0x1 linked
// Checksum 0x4752a429, Offset: 0x3848
// Size: 0x26
function remove_crawled(ent) {
    waittillframeend();
    if (isdefined(ent)) {
        ent.crawled = undefined;
    }
}

// Namespace spawner
// Params 2, eflags: 0x1 linked
// Checksum 0xce92a5ed, Offset: 0x3878
// Size: 0x1a2
function crawl_target_and_init_flags(ent, get_func) {
    targets = [];
    index = 0;
    for (;;) {
        if (!isdefined(ent.crawled)) {
            ent.crawled = 1;
            level thread remove_crawled(ent);
            if (isdefined(ent.script_flag_set)) {
                if (!isdefined(level.flag[ent.script_flag_set])) {
                    level flag::init(ent.script_flag_set);
                }
            }
            if (isdefined(ent.script_flag_wait)) {
                if (!isdefined(level.flag[ent.script_flag_wait])) {
                    level flag::init(ent.script_flag_wait);
                }
            }
            if (isdefined(ent.target)) {
                new_targets = [[ get_func ]](ent.target);
                array::add(targets, new_targets);
            }
        }
        index++;
        if (index >= targets.size) {
            break;
        }
        ent = targets[index];
    }
}

// Namespace spawner
// Params 2, eflags: 0x1 linked
// Checksum 0xc25b008f, Offset: 0x3a28
// Size: 0x22e
function get_node_funcs_based_on_target(node, goal_type) {
    get_target_func["origin"] = &get_target_ents;
    get_target_func["node"] = &get_target_nodes;
    get_target_func["struct"] = &get_target_structs;
    set_goal_func_quits["origin"] = &go_to_node_set_goal_pos;
    set_goal_func_quits["struct"] = &go_to_node_set_goal_pos;
    set_goal_func_quits["node"] = &go_to_node_set_goal_node;
    if (!isdefined(goal_type)) {
        goal_type = "node";
    }
    array = [];
    if (isdefined(node)) {
        array["node"][0] = node;
    } else {
        node = getentarray(self.target, "targetname");
        if (node.size > 0) {
            goal_type = "origin";
        }
        if (goal_type == "node") {
            node = getnodearray(self.target, "targetname");
            if (!node.size) {
                node = struct::get_array(self.target, "targetname");
                if (!node.size) {
                    return;
                }
                goal_type = "struct";
            }
        }
        array["node"] = node;
    }
    array["get_target_func"] = get_target_func[goal_type];
    array["set_goal_func_quits"] = set_goal_func_quits[goal_type];
    return array;
}

// Namespace spawner
// Params 1, eflags: 0x1 linked
// Checksum 0x2001031d, Offset: 0x3c60
// Size: 0xb8
function update_target_array(str_target) {
    a_nd_target = getnodearray(str_target, "targetname");
    if (a_nd_target.size) {
        return a_nd_target;
    }
    a_s_target = struct::get_array(str_target, "targetname");
    if (a_s_target.size) {
        return a_s_target;
    }
    a_e_target = getentarray(str_target, "targetname");
    if (a_e_target.size) {
        return a_e_target;
    }
}

// Namespace spawner
// Params 1, eflags: 0x1 linked
// Checksum 0x816c1d74, Offset: 0x3d20
// Size: 0xe4
function set_goalradius_based_on_settings(node) {
    self endon(#"death");
    waittillframeend();
    if (isdefined(self.script_radius)) {
        self.goalradius = self.script_radius;
    } else if (isdefined(node) && node_has_radius(node)) {
        self.goalradius = node.radius;
    }
    if (isdefined(self.script_forcegoal) && self.script_forcegoal) {
        n_radius = self.script_forcegoal > 1 ? self.script_forcegoal : undefined;
        self thread ai::force_goal(get_goal(self.target), n_radius);
    }
}

// Namespace spawner
// Params 2, eflags: 0x1 linked
// Checksum 0xa1ae2745, Offset: 0x3e10
// Size: 0x8a
function get_goal(str_goal, str_key) {
    if (!isdefined(str_key)) {
        str_key = "targetname";
    }
    a_goals = getnodearray(str_goal, str_key);
    if (!a_goals.size) {
        a_goals = getentarray(str_goal, str_key);
    }
    return array::random(a_goals);
}

// Namespace spawner
// Params 3, eflags: 0x1 linked
// Checksum 0x1efa1498, Offset: 0x3ea8
// Size: 0x160
function function_33f74b77(num, node_array, var_608c0bae) {
    self endon(#"death");
    level.var_cc08e38a[num] = level.var_cc08e38a[num] + self.count;
    firstspawn = 1;
    while (self.count > 0) {
        spawn = self waittill(#"spawned");
        if (firstspawn) {
            /#
                if (getdvarstring("team3") == "team3") {
                    println("team3", num);
                }
            #/
            level notify("fallback_firstspawn" + num);
            firstspawn = 0;
        }
        wait(0.05);
        if (spawn_failed(spawn)) {
            level notify("fallbacker_died" + num);
            level.var_cc08e38a[num]--;
            continue;
        }
        spawn thread function_856d632d(num, node_array, "is spawner", var_608c0bae);
    }
}

// Namespace spawner
// Params 2, eflags: 0x1 linked
// Checksum 0x45ad9a59, Offset: 0x4010
// Size: 0x44
function function_d849c7a6(ai, num) {
    ai waittill(#"death");
    level.var_fc07501b[num]--;
    level notify("fallbacker_died" + num);
}

// Namespace spawner
// Params 4, eflags: 0x1 linked
// Checksum 0x93c98db1, Offset: 0x4060
// Size: 0xdc
function function_856d632d(num, node_array, spawner, var_608c0bae) {
    if (!isdefined(self.fallback) || !isdefined(self.fallback[num])) {
        self.fallback[num] = 1;
    } else {
        return;
    }
    self.var_31afeda1 = num;
    if (!isdefined(spawner)) {
        level.var_fc07501b[num]++;
    }
    if (isdefined(node_array) && level.var_1ae79a61[num]) {
        self thread function_2b3b637c(num, node_array, var_608c0bae);
    }
    level thread function_d849c7a6(self, num);
}

// Namespace spawner
// Params 2, eflags: 0x1 linked
// Checksum 0x946de9d0, Offset: 0x4148
// Size: 0x60
function function_82718fac(ai, num) {
    ai waittill(#"death");
    if (isdefined(ai.fallback_node)) {
        ai.fallback_node.var_c8a47bf2 = 0;
    }
    level notify("fallback_reached_goal" + num);
}

// Namespace spawner
// Params 1, eflags: 0x1 linked
// Checksum 0x517e74b7, Offset: 0x41b0
// Size: 0x5a
function fallback_goal(var_608c0bae) {
    self waittill(#"goal");
    self.ignoresuppression = 0;
    if (isdefined(var_608c0bae) && var_608c0bae) {
        self.ignoreall = 0;
    }
    self notify(#"hash_e916a39");
    self notify(#"hash_7d065586");
}

// Namespace spawner
// Params 0, eflags: 0x1 linked
// Checksum 0x6aacb57d, Offset: 0x4218
// Size: 0x96
function function_e8c32f3b() {
    self notify(#"hash_51a5427a");
    self endon(#"hash_51a5427a");
    self endon(#"stop_going_to_node");
    self endon(#"hash_1f355ad7");
    self endon(#"hash_e916a39");
    self endon(#"death");
    while (true) {
        origin = self.origin;
        wait(2);
        if (self.origin == origin) {
            self.ignoreall = 0;
            return;
        }
    }
}

// Namespace spawner
// Params 3, eflags: 0x1 linked
// Checksum 0x8b83eeff, Offset: 0x42b8
// Size: 0x25c
function function_2b3b637c(num, node_array, var_608c0bae) {
    self notify(#"stop_going_to_node");
    self endon(#"stop_going_to_node");
    self endon(#"hash_1f355ad7");
    self endon(#"death");
    node = undefined;
    while (true) {
        /#
            assert(node_array.size >= level.var_fc07501b[num], "team3" + num + "team3");
        #/
        node = node_array[randomint(node_array.size)];
        if (!isdefined(node.var_c8a47bf2) || !node.var_c8a47bf2) {
            node.var_c8a47bf2 = 1;
            self.fallback_node = node;
            break;
        }
        wait(0.1);
    }
    self.ignoresuppression = 1;
    if (self.ignoreall == 0 && isdefined(var_608c0bae) && var_608c0bae) {
        self.ignoreall = 1;
        self thread function_e8c32f3b();
    }
    self setgoal(node);
    if (node.radius != 0) {
        self.goalradius = node.radius;
    }
    self endon(#"death");
    level thread function_82718fac(self, num);
    self thread fallback_goal(var_608c0bae);
    /#
        if (getdvarstring("team3") == "team3") {
            self thread function_531d7683(node.origin);
        }
    #/
    self waittill(#"hash_e916a39");
    level notify("fallback_reached_goal" + num);
}

/#

    // Namespace spawner
    // Params 1, eflags: 0x1 linked
    // Checksum 0x52d8461c, Offset: 0x4520
    // Size: 0xe0
    function function_531d7683(org) {
        self endon(#"hash_e916a39");
        self endon(#"hash_7d065586");
        self endon(#"death");
        while (true) {
            line(self.origin + (0, 0, 35), org, (0.2, 0.5, 0.8), 0.5);
            print3d(self.origin + (0, 0, 70), "team3", (0.98, 0.4, 0.26), 0.85);
            wait(0.05);
        }
    }

#/

// Namespace spawner
// Params 4, eflags: 0x1 linked
// Checksum 0x715670cf, Offset: 0x4608
// Size: 0x104
function function_64f3e104(num, group, var_608c0bae, percent) {
    var_7eb70f59 = undefined;
    nodes = getallnodes();
    for (i = 0; i < nodes.size; i++) {
        if (isdefined(nodes[i].var_31afeda1) && nodes[i].var_31afeda1 == num) {
            array::add(var_7eb70f59, nodes[i]);
        }
    }
    if (isdefined(var_7eb70f59)) {
        level thread function_76ff3fe4(num, group, var_7eb70f59, var_608c0bae, percent);
    }
}

// Namespace spawner
// Params 5, eflags: 0x1 linked
// Checksum 0x872445b8, Offset: 0x4718
// Size: 0x626
function function_76ff3fe4(num, group, var_7eb70f59, var_608c0bae, percent) {
    level.var_fc07501b[num] = 0;
    level.var_cc08e38a[num] = 0;
    level.var_1c2c9f98[num] = 0;
    level.var_1ae79a61[num] = 0;
    spawners = getspawnerarray();
    for (i = 0; i < spawners.size; i++) {
        if (isdefined(spawners[i].var_31afeda1) && spawners[i].var_31afeda1 == num) {
            if (spawners[i].count > 0) {
                spawners[i] thread function_33f74b77(num, var_7eb70f59, var_608c0bae);
                level.var_1c2c9f98[num]++;
            }
        }
    }
    /#
        assert(level.var_1c2c9f98[num] <= var_7eb70f59.size, "team3" + num);
    #/
    ai = getaiarray();
    for (i = 0; i < ai.size; i++) {
        if (isdefined(ai[i].var_31afeda1) && ai[i].var_31afeda1 == num) {
            ai[i] thread function_856d632d(num, undefined, undefined, var_608c0bae);
        }
    }
    if (!level.var_fc07501b[num] && !level.var_1c2c9f98[num]) {
        return;
    }
    spawners = undefined;
    ai = undefined;
    thread function_cb08e221(num, group, var_608c0bae, percent);
    level waittill("fallbacker_trigger" + num);
    function_20207ae5(num, var_7eb70f59);
    /#
        if (getdvarstring("team3") == "team3") {
            println("team3", num);
        }
    #/
    level.var_1ae79a61[num] = 1;
    var_2b3b637c = undefined;
    ai = getaiarray();
    for (i = 0; i < ai.size; i++) {
        if (isdefined(ai[i].script_fallback_group) && isdefined(group) && (isdefined(ai[i].var_31afeda1) && ai[i].var_31afeda1 == num || ai[i].script_fallback_group == group)) {
            array::add(var_2b3b637c, ai[i]);
        }
    }
    ai = undefined;
    if (!isdefined(var_2b3b637c)) {
        return;
    }
    if (!isdefined(percent)) {
        percent = 0.4;
    }
    var_fd0e98f = var_2b3b637c.size * percent;
    var_fd0e98f = int(var_fd0e98f);
    level notify("fallback initiated " + num);
    function_b9121c7f(var_2b3b637c, 0, var_fd0e98f);
    var_592454c4 = [];
    for (i = 0; i < var_fd0e98f; i++) {
        var_2b3b637c[i] thread function_2b3b637c(num, var_7eb70f59, var_608c0bae);
        var_592454c4[i] = var_2b3b637c[i];
    }
    for (i = 0; i < var_fd0e98f; i++) {
        level waittill("fallback_reached_goal" + num);
    }
    function_b9121c7f(var_2b3b637c, var_fd0e98f, var_2b3b637c.size);
    for (i = 0; i < var_2b3b637c.size; i++) {
        if (isalive(var_2b3b637c[i])) {
            var_4753fd0c = 1;
            for (p = 0; p < var_592454c4.size; p++) {
                if (isalive(var_592454c4[p])) {
                    if (var_2b3b637c[i] == var_592454c4[p]) {
                        var_4753fd0c = 0;
                    }
                }
            }
            if (var_4753fd0c) {
                var_2b3b637c[i] thread function_2b3b637c(num, var_7eb70f59, var_608c0bae);
            }
        }
    }
}

// Namespace spawner
// Params 3, eflags: 0x1 linked
// Checksum 0x12f745d2, Offset: 0x4d48
// Size: 0xa8
function function_b9121c7f(var_fe847c75, start, end) {
    if (gettime() <= level.var_a26bb201) {
        return;
    }
    for (i = start; i < end; i++) {
        if (!isalive(var_fe847c75[i])) {
            continue;
        }
        level.var_a26bb201 = gettime() + 2500 + randomint(2000);
        return;
    }
}

// Namespace spawner
// Params 4, eflags: 0x1 linked
// Checksum 0x24578858, Offset: 0x4df8
// Size: 0x338
function function_cb08e221(num, group, var_608c0bae, percent) {
    level endon("fallbacker_trigger" + num);
    /#
        if (getdvarstring("team3") == "team3") {
            println("team3", num);
        }
    #/
    for (i = 0; i < level.var_1c2c9f98[num]; i++) {
        /#
            if (getdvarstring("team3") == "team3") {
                println("team3", num, "team3", i);
            }
        #/
        level waittill("fallback_firstspawn" + num);
    }
    /#
        if (getdvarstring("team3") == "team3") {
            println("team3", num, "team3", level.var_fc07501b[num]);
        }
    #/
    ai = getaiarray();
    for (i = 0; i < ai.size; i++) {
        if (isdefined(ai[i].script_fallback_group) && isdefined(group) && (isdefined(ai[i].var_31afeda1) && ai[i].var_31afeda1 == num || ai[i].script_fallback_group == group)) {
            ai[i] thread function_856d632d(num, undefined, undefined, var_608c0bae);
        }
    }
    ai = undefined;
    for (var_624f7337 = 0; var_624f7337 < level.var_cc08e38a[num] * percent; var_624f7337++) {
        /#
            if (getdvarstring("team3") == "team3") {
                println("team3" + var_624f7337 + "team3" + level.var_cc08e38a[num] * 0.5);
            }
        #/
        level waittill("fallbacker_died" + num);
    }
    /#
        println(var_624f7337, "team3");
    #/
    level notify("fallbacker_trigger" + num);
}

// Namespace spawner
// Params 1, eflags: 0x1 linked
// Checksum 0xbf2c4bba, Offset: 0x5138
// Size: 0x134
function function_49ba1bae(trigger) {
    var_608c0bae = 0;
    if (isdefined(trigger.script_ignoreall) && trigger.script_ignoreall) {
        var_608c0bae = 1;
    }
    if (!isdefined(level.fallback) || !isdefined(level.fallback[trigger.var_31afeda1])) {
        percent = 0.5;
        if (isdefined(trigger.script_percent)) {
            percent = trigger.script_percent / 100;
        }
        level thread function_64f3e104(trigger.var_31afeda1, trigger.script_fallback_group, var_608c0bae, percent);
    }
    trigger waittill(#"trigger");
    level notify("fallbacker_trigger" + trigger.var_31afeda1);
    kill_trigger(trigger);
}

// Namespace spawner
// Params 2, eflags: 0x1 linked
// Checksum 0xcaf92468, Offset: 0x5278
// Size: 0x194
function function_20207ae5(num, node_array) {
    if (!isdefined(level.var_fc07501b[num - 1])) {
        return;
    }
    for (i = 0; i < level.var_fc07501b[num - 1]; i++) {
        level.var_cc08e38a[num]++;
    }
    for (i = 0; i < level.var_fc07501b[num - 1]; i++) {
        level.var_fc07501b[num]++;
    }
    ai = getaiarray();
    for (i = 0; i < ai.size; i++) {
        if (isdefined(ai[i].var_31afeda1) && ai[i].var_31afeda1 == num - 1) {
            ai[i].var_31afeda1++;
            if (isdefined(ai[i].fallback_node)) {
                ai[i].fallback_node.var_c8a47bf2 = 0;
                ai[i].fallback_node = undefined;
            }
        }
    }
}

// Namespace spawner
// Params 2, eflags: 0x1 linked
// Checksum 0x6bc4be44, Offset: 0x5418
// Size: 0x28c
function aigroup_init(aigroup, spawner) {
    if (!isdefined(level._ai_group[aigroup])) {
        level._ai_group[aigroup] = spawnstruct();
        level._ai_group[aigroup].aigroup = aigroup;
        level._ai_group[aigroup].aicount = 0;
        level._ai_group[aigroup].killed_count = 0;
        level._ai_group[aigroup].ai = [];
        level._ai_group[aigroup].spawners = [];
        level._ai_group[aigroup].cleared_count = 0;
        if (!isdefined(level.flag[aigroup + "_cleared"])) {
            level flag::init(aigroup + "_cleared");
        }
        if (!isdefined(level.flag[aigroup + "_spawning"])) {
            level flag::init(aigroup + "_spawning");
        }
        level thread set_ai_group_cleared_flag(level._ai_group[aigroup]);
    }
    if (isdefined(spawner)) {
        if (!isdefined(level._ai_group[aigroup].spawners)) {
            level._ai_group[aigroup].spawners = [];
        } else if (!isarray(level._ai_group[aigroup].spawners)) {
            level._ai_group[aigroup].spawners = array(level._ai_group[aigroup].spawners);
        }
        level._ai_group[aigroup].spawners[level._ai_group[aigroup].spawners.size] = spawner;
        spawner thread aigroup_spawner_death(level._ai_group[aigroup]);
    }
}

// Namespace spawner
// Params 1, eflags: 0x1 linked
// Checksum 0xbdf63f13, Offset: 0x56b0
// Size: 0x44
function aigroup_spawner_death(tracker) {
    self util::waittill_any("death", "aigroup_spawner_death");
    tracker notify(#"update_aigroup");
}

// Namespace spawner
// Params 1, eflags: 0x1 linked
// Checksum 0xdff95000, Offset: 0x5700
// Size: 0xe0
function aigroup_think(tracker) {
    tracker.aicount++;
    tracker.ai[tracker.ai.size] = self;
    tracker notify(#"update_aigroup");
    if (isdefined(self.script_deathflag_longdeath)) {
        self waittilldeathorpaindeath();
    } else {
        self waittill(#"death");
    }
    tracker.aicount--;
    tracker.killed_count++;
    tracker notify(#"update_aigroup");
    wait(0.05);
    tracker.ai = array::remove_undefined(tracker.ai);
}

// Namespace spawner
// Params 1, eflags: 0x1 linked
// Checksum 0x9817c55c, Offset: 0x57e8
// Size: 0x8c
function set_ai_group_cleared_flag(tracker) {
    waittillframeend();
    while (tracker.aicount + get_ai_group_spawner_count(tracker.aigroup) > tracker.cleared_count) {
        tracker waittill(#"update_aigroup");
    }
    level flag::set(tracker.aigroup + "_cleared");
}

// Namespace spawner
// Params 1, eflags: 0x1 linked
// Checksum 0xc15e6d62, Offset: 0x5880
// Size: 0x17c
function flood_trigger_think(trigger) {
    /#
        assert(isdefined(trigger.target), "team3" + trigger.origin + "team3");
    #/
    var_9207c87c = getentarray(trigger.target, "targetname");
    /#
        assert(var_9207c87c.size, "team3" + trigger.target + "team3");
    #/
    for (i = 0; i < var_9207c87c.size; i++) {
        var_9207c87c[i].var_8be655f9 = trigger;
    }
    array::thread_all(var_9207c87c, &flood_spawner_init);
    trigger waittill(#"trigger");
    var_9207c87c = getentarray(trigger.target, "targetname");
    array::thread_all(var_9207c87c, &flood_spawner_think, trigger);
}

// Namespace spawner
// Params 1, eflags: 0x1 linked
// Checksum 0x19f6b350, Offset: 0x5a08
// Size: 0x7c
function flood_spawner_init(spawner) {
    /#
        assert(isdefined(self.spawnflags) && (self.spawnflags & 1) == 1, "team3" + self.origin + "team3" + self getorigin() + "team3");
    #/
}

// Namespace spawner
// Params 1, eflags: 0x1 linked
// Checksum 0x1e3065fd, Offset: 0x5a90
// Size: 0x28
function trigger_requires_player(trigger) {
    if (!isdefined(trigger)) {
        return false;
    }
    return isdefined(trigger.script_requires_player);
}

// Namespace spawner
// Params 1, eflags: 0x1 linked
// Checksum 0x5f93ff34, Offset: 0x5ac0
// Size: 0x258
function flood_spawner_think(trigger) {
    self endon(#"death");
    self notify(#"hash_87140c16");
    self endon(#"hash_87140c16");
    var_118b0c63 = trigger_requires_player(trigger);
    util::script_delay();
    while (self.count > 0) {
        if (var_118b0c63) {
            while (!util::any_player_is_touching(trigger)) {
                wait(0.5);
            }
        }
        soldier = self spawn();
        if (spawn_failed(soldier)) {
            wait(2);
            continue;
        }
        soldier thread reincrement_count_if_deleted(self);
        attacker = soldier waittill(#"death");
        if (!player_saw_kill(soldier, attacker)) {
            self.count++;
        }
        if (!isdefined(soldier)) {
            continue;
        }
        if (!util::script_wait(1)) {
            players = getplayers();
            if (players.size == 1) {
                wait(randomfloatrange(5, 9));
                continue;
            }
            if (players.size == 2) {
                wait(randomfloatrange(3, 6));
                continue;
            }
            if (players.size == 3) {
                wait(randomfloatrange(1, 4));
                continue;
            }
            if (players.size == 4) {
                wait(randomfloatrange(0.5, 1.5));
            }
        }
    }
}

// Namespace spawner
// Params 2, eflags: 0x1 linked
// Checksum 0xf382496e, Offset: 0x5d20
// Size: 0x252
function player_saw_kill(guy, attacker) {
    if (isdefined(self.script_force_count)) {
        if (self.script_force_count) {
            return 1;
        }
    }
    if (!isdefined(guy)) {
        return 0;
    }
    if (isalive(attacker)) {
        if (isplayer(attacker)) {
            return 1;
        }
        players = getplayers();
        for (q = 0; q < players.size; q++) {
            if (distancesquared(attacker.origin, players[q].origin) < 40000) {
                return 1;
            }
        }
    } else if (isdefined(attacker)) {
        if (attacker.classname == "worldspawn") {
            return 0;
        }
        player = util::get_closest_player(attacker.origin);
        if (isdefined(player) && distancesquared(attacker.origin, player.origin) < 40000) {
            return 1;
        }
    }
    closest_player = util::get_closest_player(guy.origin);
    if (isdefined(closest_player) && distancesquared(guy.origin, closest_player.origin) < 40000) {
        return 1;
    }
    return bullettracepassed(closest_player geteye(), guy geteye(), 0, undefined);
}

/#

    // Namespace spawner
    // Params 0, eflags: 0x1 linked
    // Checksum 0x360cfb9, Offset: 0x5f80
    // Size: 0x112
    function show_bad_path() {
        self endon(#"death");
        var_4cbb8d8f = -5000;
        var_4f4949c4 = 0;
        for (;;) {
            var_ac03227f = self waittill(#"bad_path");
            if (!isdefined(level.var_bce48547) || !level.var_bce48547) {
                continue;
            }
            if (gettime() - var_4cbb8d8f > 5000) {
                var_4f4949c4 = 0;
            } else {
                var_4f4949c4++;
            }
            var_4cbb8d8f = gettime();
            if (var_4f4949c4 < 10) {
                continue;
            }
            for (p = 0; p < -56; p++) {
                line(self.origin, var_ac03227f, (1, 0.4, 0.1), 0, -56);
                wait(0.05);
            }
        }
    }

#/

// Namespace spawner
// Params 0, eflags: 0x0
// Checksum 0x85934c07, Offset: 0x60a0
// Size: 0x8
function function_3826a243() {
    return true;
}

// Namespace spawner
// Params 5, eflags: 0x1 linked
// Checksum 0x4042a05f, Offset: 0x60b0
// Size: 0x886
function spawn(b_force, str_targetname, v_origin, v_angles, bignorespawninglimit) {
    if (!isdefined(b_force)) {
        b_force = 0;
    }
    if (isdefined(level.var_78175c63) && self.team == "axis") {
        return [[ level.var_78175c63 ]](b_force, str_targetname, v_origin, v_angles);
    }
    e_spawned = undefined;
    force_spawn = 0;
    makeroom = 0;
    infinitespawn = 0;
    deleteonzerocount = 0;
    /#
        if (getdvarstring("team3") != "team3") {
            return;
        }
    #/
    if (!check_player_requirements()) {
        return;
    }
    while (true) {
        if (!(isdefined(bignorespawninglimit) && bignorespawninglimit) && !(isdefined(self.ignorespawninglimit) && self.ignorespawninglimit)) {
            global_spawn_throttle(1);
        }
        if (sessionmodeiscampaignzombiesgame() && !isdefined(self)) {
            return;
        }
        if (isdefined(self.lastspawntime) && self.lastspawntime >= gettime()) {
            wait(0.05);
            continue;
        }
        break;
    }
    if (isactorspawner(self)) {
        if (isdefined(self.spawnflags) && (self.spawnflags & 2) == 2) {
            makeroom = 1;
        }
    } else if (isvehiclespawner(self)) {
        if (isdefined(self.spawnflags) && (self.spawnflags & 8) == 8) {
            makeroom = 1;
        }
    }
    if (isdefined(self.spawnflags) && (b_force || (self.spawnflags & 16) == 16) || isdefined(self.script_forcespawn)) {
        force_spawn = 1;
    }
    if (isdefined(self.spawnflags) && (self.spawnflags & 64) == 64) {
        infinitespawn = 1;
    }
    /#
        if (isdefined(level.archetype_spawners) && isarray(level.archetype_spawners)) {
            archetype_spawner = undefined;
            if (self.team == "team3") {
                archetype = getdvarstring("team3");
                if (getdvarstring("team3") == "team3") {
                    archetype = getdvarstring("team3");
                }
                archetype_spawner = level.archetype_spawners[archetype];
            } else if (self.team == "team3") {
                archetype = getdvarstring("team3");
                if (getdvarstring("team3") == "team3") {
                    archetype = getdvarstring("team3");
                }
                archetype_spawner = level.archetype_spawners[archetype];
            }
            if (isspawner(archetype_spawner)) {
                while (isdefined(archetype_spawner.lastspawntime) && archetype_spawner.lastspawntime >= gettime()) {
                    wait(0.05);
                }
                originalorigin = archetype_spawner.origin;
                originalangles = archetype_spawner.angles;
                originaltarget = archetype_spawner.target;
                originaltargetname = archetype_spawner.targetname;
                archetype_spawner.target = self.target;
                archetype_spawner.targetname = self.targetname;
                archetype_spawner.script_noteworthy = self.script_noteworthy;
                archetype_spawner.script_string = self.script_string;
                archetype_spawner.origin = self.origin;
                archetype_spawner.angles = self.angles;
                e_spawned = archetype_spawner spawnfromspawner(str_targetname, force_spawn, makeroom, infinitespawn);
                archetype_spawner.target = originaltarget;
                archetype_spawner.targetname = originaltargetname;
                archetype_spawner.origin = originalorigin;
                archetype_spawner.angles = originalangles;
                if (isdefined(archetype_spawner.spawnflags) && (archetype_spawner.spawnflags & 64) == 64) {
                    archetype_spawner.count++;
                }
                archetype_spawner.lastspawntime = gettime();
            }
        }
    #/
    if (!isdefined(e_spawned)) {
        var_f7357650 = undefined;
        use_female = randomint(100) < level.female_percent;
        if (level.dont_use_female_replacements === 1) {
            use_female = 0;
        }
        if (use_female && isdefined(self.aitypevariant)) {
            e_spawned = self spawnfromspawner(str_targetname, force_spawn, makeroom, infinitespawn, "actor_" + self.aitypevariant);
        } else {
            override_aitype = undefined;
            if (isdefined(level.override_spawned_aitype_func)) {
                override_aitype = [[ level.override_spawned_aitype_func ]](self);
            }
            if (isdefined(override_aitype)) {
                e_spawned = self spawnfromspawner(str_targetname, force_spawn, makeroom, infinitespawn, override_aitype);
            } else {
                e_spawned = self spawnfromspawner(str_targetname, force_spawn, makeroom, infinitespawn);
            }
        }
    }
    if (isdefined(e_spawned)) {
        if (isdefined(level.run_custom_function_on_ai)) {
            if (isdefined(archetype_spawner)) {
                e_spawned thread [[ level.run_custom_function_on_ai ]](archetype_spawner, str_targetname, force_spawn);
            } else {
                e_spawned thread [[ level.run_custom_function_on_ai ]](self, str_targetname, force_spawn);
            }
        }
        if (isdefined(v_origin) || isdefined(v_angles)) {
            e_spawned teleport_spawned(v_origin, v_angles);
        }
        self.lastspawntime = gettime();
    }
    if (isdefined(self.script_delete_on_zero) && (deleteonzerocount || self.script_delete_on_zero) && isdefined(self.count) && self.count <= 0) {
        self delete();
    }
    if (issentient(e_spawned)) {
        if (!spawn_failed(e_spawned)) {
            return e_spawned;
        }
        return;
    }
    return e_spawned;
}

// Namespace spawner
// Params 3, eflags: 0x1 linked
// Checksum 0xd31c8fb2, Offset: 0x6940
// Size: 0xb8
function teleport_spawned(v_origin, v_angles, b_reset_entity) {
    if (!isdefined(b_reset_entity)) {
        b_reset_entity = 1;
    }
    if (!isdefined(v_origin)) {
        v_origin = self.origin;
    }
    if (!isdefined(v_angles)) {
        v_angles = self.angles;
    }
    if (isactor(self)) {
        self forceteleport(v_origin, v_angles, 1, b_reset_entity);
        return;
    }
    self.origin = v_origin;
    self.angles = v_angles;
}

// Namespace spawner
// Params 0, eflags: 0x1 linked
// Checksum 0xd9fcf32e, Offset: 0x6a00
// Size: 0xfc
function check_player_requirements() {
    if (isdefined(level.players) && level.players.size > 0) {
        n_player_count = level.players.size;
    } else {
        n_player_count = getnumexpectedplayers();
    }
    if (isdefined(self.script_minplayers)) {
        if (n_player_count < self.script_minplayers) {
            self delete();
            return false;
        }
    }
    if (isdefined(self.script_numplayers)) {
        if (n_player_count < self.script_numplayers) {
            self delete();
            return false;
        }
    }
    if (isdefined(self.script_maxplayers)) {
        if (n_player_count > self.script_maxplayers) {
            self delete();
            return false;
        }
    }
    return true;
}

// Namespace spawner
// Params 1, eflags: 0x1 linked
// Checksum 0x90d54c0d, Offset: 0x6b08
// Size: 0x66
function spawn_failed(spawn) {
    if (isalive(spawn)) {
        if (!isdefined(spawn.finished_spawning)) {
            spawn waittill(#"hash_f42b7e06");
        }
        waittillframeend();
        if (isalive(spawn)) {
            return false;
        }
    }
    return true;
}

// Namespace spawner
// Params 1, eflags: 0x0
// Checksum 0x93e61a03, Offset: 0x6b78
// Size: 0xb2
function kill_spawnernum(number) {
    foreach (sp in getspawnerarray("" + number, "script_killspawner")) {
        sp delete();
    }
}

// Namespace spawner
// Params 0, eflags: 0x0
// Checksum 0xc7ead2bb, Offset: 0x6c38
// Size: 0x1a
function disable_replace_on_death() {
    self.replace_on_death = undefined;
    self notify(#"_disable_reinforcement");
}

// Namespace spawner
// Params 0, eflags: 0x1 linked
// Checksum 0x822c5bad, Offset: 0x6c60
// Size: 0x14
function replace_on_death() {
    colors::colornode_replace_on_death();
}

// Namespace spawner
// Params 2, eflags: 0x0
// Checksum 0x8e35876b, Offset: 0x6c80
// Size: 0x48
function set_ai_group_cleared_count(aigroup, count) {
    aigroup_init(aigroup);
    level._ai_group[aigroup].cleared_count = count;
}

// Namespace spawner
// Params 1, eflags: 0x1 linked
// Checksum 0x6972ef5f, Offset: 0x6cd0
// Size: 0x64
function waittill_ai_group_cleared(aigroup) {
    /#
        assert(isdefined(level._ai_group[aigroup]), "team3" + aigroup + "team3");
    #/
    level flag::wait_till(aigroup + "_cleared");
}

// Namespace spawner
// Params 2, eflags: 0x0
// Checksum 0x10748141, Offset: 0x6d40
// Size: 0x6c
function waittill_ai_group_count(aigroup, count) {
    while (get_ai_group_spawner_count(aigroup) + level._ai_group[aigroup].aicount > count) {
        level._ai_group[aigroup] waittill(#"update_aigroup");
    }
}

// Namespace spawner
// Params 2, eflags: 0x0
// Checksum 0xeab9fe90, Offset: 0x6db8
// Size: 0x50
function waittill_ai_group_ai_count(aigroup, count) {
    while (level._ai_group[aigroup].aicount > count) {
        level._ai_group[aigroup] waittill(#"update_aigroup");
    }
}

// Namespace spawner
// Params 2, eflags: 0x0
// Checksum 0x63761db9, Offset: 0x6e10
// Size: 0x50
function waittill_ai_group_spawner_count(aigroup, count) {
    while (get_ai_group_spawner_count(aigroup) > count) {
        level._ai_group[aigroup] waittill(#"update_aigroup");
    }
}

// Namespace spawner
// Params 2, eflags: 0x0
// Checksum 0xf497b943, Offset: 0x6e68
// Size: 0x50
function waittill_ai_group_amount_killed(aigroup, amount_killed) {
    while (level._ai_group[aigroup].killed_count < amount_killed) {
        level._ai_group[aigroup] waittill(#"update_aigroup");
    }
}

// Namespace spawner
// Params 1, eflags: 0x0
// Checksum 0x773f74a4, Offset: 0x6ec0
// Size: 0x3c
function get_ai_group_count(aigroup) {
    return get_ai_group_spawner_count(aigroup) + level._ai_group[aigroup].aicount;
}

// Namespace spawner
// Params 1, eflags: 0x0
// Checksum 0xef932398, Offset: 0x6f08
// Size: 0x22
function get_ai_group_sentient_count(aigroup) {
    return level._ai_group[aigroup].aicount;
}

// Namespace spawner
// Params 1, eflags: 0x1 linked
// Checksum 0x75d3c609, Offset: 0x6f38
// Size: 0xc4
function get_ai_group_spawner_count(aigroup) {
    n_count = 0;
    foreach (sp in level._ai_group[aigroup].spawners) {
        if (isdefined(sp)) {
            n_count += sp.count;
        }
    }
    return n_count;
}

// Namespace spawner
// Params 1, eflags: 0x0
// Checksum 0xfc936176, Offset: 0x7008
// Size: 0xbc
function get_ai_group_ai(aigroup) {
    aiset = [];
    for (index = 0; index < level._ai_group[aigroup].ai.size; index++) {
        if (!isalive(level._ai_group[aigroup].ai[index])) {
            continue;
        }
        aiset[aiset.size] = level._ai_group[aigroup].ai[index];
    }
    return aiset;
}

// Namespace spawner
// Params 7, eflags: 0x1 linked
// Checksum 0xd8342a99, Offset: 0x70d0
// Size: 0x198
function add_global_spawn_function(team, spawn_func, param1, param2, param3, param4, param5) {
    if (!isdefined(level.spawn_funcs)) {
        level.spawn_funcs = [];
    }
    if (!isdefined(level.spawn_funcs[team])) {
        level.spawn_funcs[team] = [];
    }
    func = [];
    func["function"] = spawn_func;
    func["param1"] = param1;
    func["param2"] = param2;
    func["param3"] = param3;
    func["param4"] = param4;
    func["param5"] = param5;
    if (!isdefined(level.spawn_funcs[team])) {
        level.spawn_funcs[team] = [];
    } else if (!isarray(level.spawn_funcs[team])) {
        level.spawn_funcs[team] = array(level.spawn_funcs[team]);
    }
    level.spawn_funcs[team][level.spawn_funcs[team].size] = func;
}

// Namespace spawner
// Params 7, eflags: 0x1 linked
// Checksum 0x9d501e2e, Offset: 0x7270
// Size: 0x198
function add_archetype_spawn_function(archetype, spawn_func, param1, param2, param3, param4, param5) {
    if (!isdefined(level.spawn_funcs)) {
        level.spawn_funcs = [];
    }
    if (!isdefined(level.spawn_funcs[archetype])) {
        level.spawn_funcs[archetype] = [];
    }
    func = [];
    func["function"] = spawn_func;
    func["param1"] = param1;
    func["param2"] = param2;
    func["param3"] = param3;
    func["param4"] = param4;
    func["param5"] = param5;
    if (!isdefined(level.spawn_funcs[archetype])) {
        level.spawn_funcs[archetype] = [];
    } else if (!isarray(level.spawn_funcs[archetype])) {
        level.spawn_funcs[archetype] = array(level.spawn_funcs[archetype]);
    }
    level.spawn_funcs[archetype][level.spawn_funcs[archetype].size] = func;
}

// Namespace spawner
// Params 2, eflags: 0x1 linked
// Checksum 0x72555217, Offset: 0x7410
// Size: 0xd2
function remove_global_spawn_function(team, func) {
    if (isdefined(level.spawn_funcs) && isdefined(level.spawn_funcs[team])) {
        array = [];
        for (i = 0; i < level.spawn_funcs[team].size; i++) {
            if (level.spawn_funcs[team][i]["function"] != func) {
                array[array.size] = level.spawn_funcs[team][i];
            }
        }
        level.spawn_funcs[team] = array;
    }
}

// Namespace spawner
// Params 6, eflags: 0x1 linked
// Checksum 0xc9f651f, Offset: 0x74f0
// Size: 0x12a
function add_spawn_function(spawn_func, param1, param2, param3, param4, param5) {
    /#
        assert(!isdefined(level._loadstarted) || !isalive(self), "team3");
    #/
    func = [];
    func["function"] = spawn_func;
    func["param1"] = param1;
    func["param2"] = param2;
    func["param3"] = param3;
    func["param4"] = param4;
    func["param5"] = param5;
    if (!isdefined(self.spawn_funcs)) {
        self.spawn_funcs = [];
    }
    self.spawn_funcs[self.spawn_funcs.size] = func;
}

// Namespace spawner
// Params 1, eflags: 0x1 linked
// Checksum 0x1268af1f, Offset: 0x7628
// Size: 0x110
function remove_spawn_function(func) {
    /#
        assert(!isdefined(level._loadstarted) || !isalive(self), "team3");
    #/
    if (isdefined(self.spawn_funcs)) {
        array = [];
        for (i = 0; i < self.spawn_funcs.size; i++) {
            if (self.spawn_funcs[i]["function"] != func) {
                array[array.size] = self.spawn_funcs[i];
            }
        }
        /#
            assert(self.spawn_funcs.size != array.size, "team3");
        #/
        self.spawn_funcs = array;
    }
}

// Namespace spawner
// Params 8, eflags: 0x0
// Checksum 0x56d7c2da, Offset: 0x7740
// Size: 0x10c
function add_spawn_function_group(str_value, str_key, func_spawn, param_1, param_2, param_3, param_4, param_5) {
    if (!isdefined(str_key)) {
        str_key = "targetname";
    }
    /#
        assert(isdefined(str_value), "team3");
    #/
    /#
        assert(isdefined(func_spawn), "team3");
    #/
    a_spawners = getspawnerarray(str_value, str_key);
    array::run_all(a_spawners, &add_spawn_function, func_spawn, param_1, param_2, param_3, param_4, param_5);
}

// Namespace spawner
// Params 7, eflags: 0x0
// Checksum 0x4defd897, Offset: 0x7858
// Size: 0xf4
function add_spawn_function_ai_group(str_aigroup, func_spawn, param_1, param_2, param_3, param_4, param_5) {
    /#
        assert(isdefined(str_aigroup), "team3");
    #/
    /#
        assert(isdefined(func_spawn), "team3");
    #/
    a_spawners = getspawnerarray(str_aigroup, "script_aigroup");
    array::run_all(a_spawners, &add_spawn_function, func_spawn, param_1, param_2, param_3, param_4, param_5);
}

// Namespace spawner
// Params 7, eflags: 0x0
// Checksum 0x1caf5be3, Offset: 0x7958
// Size: 0xdc
function remove_spawn_function_ai_group(str_aigroup, func_spawn, param_1, param_2, param_3, param_4, param_5) {
    /#
        assert(isdefined(str_aigroup), "team3");
    #/
    /#
        assert(isdefined(func_spawn), "team3");
    #/
    a_spawners = getspawnerarray(str_aigroup, "script_aigroup");
    array::run_all(a_spawners, &remove_spawn_function, func_spawn);
}

// Namespace spawner
// Params 3, eflags: 0x0
// Checksum 0xf16b73ee, Offset: 0x7a40
// Size: 0x19e
function function_210232b6(name, spawn_func, var_663d6984) {
    spawners = getentarray(name, "targetname");
    /#
        assert(spawners.size, "team3" + name + "team3");
    #/
    if (isdefined(spawn_func)) {
        for (i = 0; i < spawners.size; i++) {
            spawners[i] add_spawn_function(spawn_func);
        }
    }
    if (isdefined(var_663d6984)) {
        for (i = 0; i < spawners.size; i++) {
            spawners[i] add_spawn_function(var_663d6984);
        }
    }
    for (i = 0; i < spawners.size; i++) {
        if (i % 2) {
            util::wait_network_frame();
        }
        spawners[i] thread flood_spawner_init();
        spawners[i] thread flood_spawner_think();
    }
}

// Namespace spawner
// Params 8, eflags: 0x1 linked
// Checksum 0x8797b29a, Offset: 0x7be8
// Size: 0x264
function simple_spawn(name_or_spawners, spawn_func, param1, param2, param3, param4, param5, var_4ae51086) {
    spawners = [];
    if (isstring(name_or_spawners)) {
        spawners = getentarray(name_or_spawners, "targetname");
        /#
            assert(spawners.size, "team3" + name_or_spawners + "team3");
        #/
    } else {
        if (!isdefined(name_or_spawners)) {
            name_or_spawners = [];
        } else if (!isarray(name_or_spawners)) {
            name_or_spawners = array(name_or_spawners);
        }
        spawners = name_or_spawners;
    }
    a_spawned = [];
    foreach (sp in spawners) {
        e_spawned = sp spawn(var_4ae51086);
        if (isdefined(e_spawned)) {
            if (isdefined(spawn_func)) {
                util::single_thread(e_spawned, spawn_func, param1, param2, param3, param4, param5);
            }
            if (!isdefined(a_spawned)) {
                a_spawned = [];
            } else if (!isarray(a_spawned)) {
                a_spawned = array(a_spawned);
            }
            a_spawned[a_spawned.size] = e_spawned;
        }
    }
    return a_spawned;
}

// Namespace spawner
// Params 8, eflags: 0x1 linked
// Checksum 0xfec77c50, Offset: 0x7e58
// Size: 0xc0
function simple_spawn_single(name_or_spawner, spawn_func, param1, param2, param3, param4, param5, var_4ae51086) {
    ai = simple_spawn(name_or_spawner, spawn_func, param1, param2, param3, param4, param5, var_4ae51086);
    /#
        assert(ai.size <= 1, "team3");
    #/
    if (ai.size) {
        return ai[0];
    }
}

// Namespace spawner
// Params 1, eflags: 0x0
// Checksum 0x8823e476, Offset: 0x7f20
// Size: 0x3c
function function_74f0a2dc(var_8ac7bd04) {
    self thread go_to_spawner_target(strtok(var_8ac7bd04, " "));
}

/#

    // Namespace spawner
    // Params 1, eflags: 0x1 linked
    // Checksum 0xaaffa16e, Offset: 0x7f68
    // Size: 0x8a
    function getscoreinfoxp(type) {
        if (isdefined(level.scoreinfo) && isdefined(level.scoreinfo[type])) {
            n_xp = level.scoreinfo[type]["team3"];
            if (isdefined(level.xpmodifiercallback) && isdefined(n_xp)) {
                n_xp = [[ level.xpmodifiercallback ]](type, n_xp);
            }
            return n_xp;
        }
    }

    // Namespace spawner
    // Params 0, eflags: 0x2
    // Checksum 0x54b03394, Offset: 0x8000
    // Size: 0x13c
    function autoexec function_63a40f84() {
        level.var_d4b93527 = [];
        level.var_50c49a7f = "team3";
        callback::add_callback(#"hash_8c38c12e", &function_1fe733b8);
        callback::add_callback(#"hash_acb66515", &function_fbf3ae73);
        callback::add_callback(#"hash_7b543e98", &function_fa4961d4);
        callback::add_callback(#"hash_9bd1e27f", &function_2984c1c9);
        setdvar("team3", 0);
        setdvar("team3", 0);
        setdvar("team3", 0);
        setdvar("team3", 0);
        level thread function_6ec0d40f();
    }

    // Namespace spawner
    // Params 1, eflags: 0x1 linked
    // Checksum 0x1771125f, Offset: 0x8148
    // Size: 0x134
    function function_fbf3ae73(params) {
        b_killed_by_player = 0;
        if (isdefined(params) && isplayer(params.eattacker)) {
            b_killed_by_player = 1;
            if (getdvarint("team3")) {
                var_f695f102 = getscoreinfoxp("team3" + self.scoretype);
                var_4df005d0 = self.origin;
                var_31fea095 = 50;
                if (isdefined(self.height)) {
                    var_31fea095 = self.height;
                }
                var_4df005d0 += (0, 0, var_31fea095);
                function_8ba6ca57(var_f695f102, var_4df005d0);
            }
        }
        function_2795d1ea(b_killed_by_player);
    }

    // Namespace spawner
    // Params 1, eflags: 0x1 linked
    // Checksum 0x2e4c830b, Offset: 0x8288
    // Size: 0x124
    function function_1fe733b8(params) {
        b_killed_by_player = 0;
        if (isplayer(params.eattacker)) {
            b_killed_by_player = 1;
            if (getdvarint("team3")) {
                var_f695f102 = getscoreinfoxp("team3" + self.scoretype);
                var_4df005d0 = self.origin;
                var_31fea095 = 72;
                if (isdefined(self.goalheight)) {
                    var_31fea095 = self.goalheight - 12;
                }
                var_4df005d0 += (0, 0, var_31fea095);
                function_8ba6ca57(var_f695f102, var_4df005d0);
            }
        }
        function_2795d1ea(b_killed_by_player);
    }

    // Namespace spawner
    // Params 1, eflags: 0x1 linked
    // Checksum 0x8f68f498, Offset: 0x83b8
    // Size: 0x13c
    function function_fa4961d4(params) {
        var_6255a1d2 = (0, 0, 0);
        var_1f95466d = params.idamage;
        if (getdvarstring("team3") == "team3") {
            if (isdefined(self gettagorigin("team3"))) {
                v_position = self gettagorigin("team3") + (0, 0, 18);
            } else {
                v_position = self getorigin() + (0, 0, 78);
            }
            level thread function_440d13a9(var_1f95466d, v_position, "team3", "team3", (0.96, 0.12, 0.12), 1, 0.6);
        }
    }

    // Namespace spawner
    // Params 1, eflags: 0x1 linked
    // Checksum 0xddc7639f, Offset: 0x8500
    // Size: 0xfc
    function function_2984c1c9(params) {
        var_6255a1d2 = (0, 0, 0);
        var_1f95466d = params.idamage;
        if (getdvarstring("team3") == "team3") {
            var_6255a1d2 = self.origin;
            var_31fea095 = 50;
            if (isdefined(self.height)) {
                var_31fea095 = self.height;
            }
            var_6255a1d2 += (0, 0, var_31fea095);
            level thread function_440d13a9(var_1f95466d, var_6255a1d2, "team3", "team3", (0.96, 0.12, 0.12), 1, 0.6);
        }
    }

    // Namespace spawner
    // Params 2, eflags: 0x1 linked
    // Checksum 0xba0335d1, Offset: 0x8608
    // Size: 0x6c
    function function_8ba6ca57(var_f695f102, v_position) {
        level thread function_440d13a9(var_f695f102, v_position, "team3", "team3", (0.83, 0.18, 0.76), 1, 0.7);
    }

    // Namespace spawner
    // Params 7, eflags: 0x1 linked
    // Checksum 0x57f4fe92, Offset: 0x8680
    // Size: 0x10a
    function function_440d13a9(n_value, v_pos, var_4b5575e9, var_1e91eabe, color, n_alpha, n_size) {
        var_6182c14d = 0;
        var_7578a666 = n_alpha;
        var_2ea9cc6d = v_pos;
        while (var_6182c14d < 40) {
            var_2ea9cc6d += (0, 0, 1.125);
            print3d(var_2ea9cc6d, var_4b5575e9 + n_value + var_1e91eabe, color, var_7578a666, n_size, 1);
            if (var_6182c14d >= 20) {
                var_7578a666 -= 1 / 20;
            }
            wait(0.05);
            var_6182c14d++;
        }
    }

    // Namespace spawner
    // Params 1, eflags: 0x1 linked
    // Checksum 0x64225c33, Offset: 0x8798
    // Size: 0x60
    function function_5671da7d(e_enemy) {
        var_f695f102 = getscoreinfoxp("team3" + e_enemy.scoretype);
        if (isdefined(var_f695f102)) {
            return var_f695f102;
        }
        return 0;
    }

    // Namespace spawner
    // Params 1, eflags: 0x1 linked
    // Checksum 0x331d1f5f, Offset: 0x8800
    // Size: 0x25a
    function function_2795d1ea(b_killed_by_player) {
        if (!isdefined(self)) {
            return;
        }
        if (self.team == "team3" || self.team == "team3") {
            var_b28093b = 0;
            for (i = 0; i < level.var_d4b93527.size; i++) {
                if (level.var_d4b93527[i].var_af46d184 == self.scoretype) {
                    level.var_d4b93527[i].icount = level.var_d4b93527[i].icount + 1;
                    if (b_killed_by_player) {
                        level.var_d4b93527[i].var_50b2a78e = level.var_d4b93527[i].var_50b2a78e + 1;
                        if (isdefined(level.var_d4b93527[i].var_1f8e7452)) {
                            level.var_d4b93527[i].var_1f8e7452 = level.var_d4b93527[i].var_1f8e7452 + function_5671da7d(self);
                        }
                    }
                    var_b28093b = 1;
                }
            }
            if (!var_b28093b) {
                var_698fd26a = spawnstruct();
                var_698fd26a.var_af46d184 = self.scoretype;
                var_698fd26a.icount = 1;
                var_698fd26a.var_50b2a78e = 0;
                var_698fd26a.var_1f8e7452 = 0;
                if (b_killed_by_player) {
                    var_698fd26a.var_50b2a78e = 1;
                    var_698fd26a.var_1f8e7452 = function_5671da7d(self);
                }
                var_7181db51 = level.var_d4b93527.size;
                level.var_d4b93527[var_7181db51] = var_698fd26a;
            }
        }
    }

    // Namespace spawner
    // Params 0, eflags: 0x1 linked
    // Checksum 0xa62c4046, Offset: 0x8a68
    // Size: 0x2e8
    function function_6ec0d40f() {
        while (true) {
            function_d8312e();
            if (getdvarint("team3") == 1) {
                if (!isdefined(level.var_4436cad5)) {
                    level.var_4436cad5 = newhudelem();
                    level.var_4436cad5.alignx = "team3";
                    level.var_4436cad5.x = 50;
                    level.var_4436cad5.y = 60;
                    level.var_4436cad5.fontscale = 1.5;
                    level.var_4436cad5.color = (1, 1, 1);
                    iprintlnbold("team3");
                } else {
                    level.var_87874699 = "team3" + getaiteamarray("team3").size + "team3" + getaiteamarray("team3").size + "team3";
                    level.var_87874699 += "team3";
                    if (level.var_d4b93527.size == 0) {
                        level.var_87874699 += "team3";
                    } else {
                        foreach (var_2b2af279 in level.var_d4b93527) {
                            level.var_87874699 = level.var_87874699 + var_2b2af279.var_af46d184 + "team3" + var_2b2af279.icount + "team3" + var_2b2af279.var_50b2a78e + "team3";
                        }
                    }
                    if (getdvarint("team3") == 1) {
                        level.var_4436cad5 settext(level.var_87874699);
                    }
                }
            } else if (isdefined(level.var_4436cad5)) {
                level.var_4436cad5 destroy();
                iprintlnbold("team3");
            }
            wait(0.25);
        }
    }

    // Namespace spawner
    // Params 0, eflags: 0x1 linked
    // Checksum 0x6e212213, Offset: 0x8d58
    // Size: 0x6c
    function function_d8312e() {
        if (getdvarint("team3") == 1) {
            level.var_d4b93527 = [];
            iprintln("team3");
            setdvar("team3", 0);
        }
    }

#/

// Namespace spawner
// Params 0, eflags: 0x2
// Checksum 0x432f6d00, Offset: 0x8dd0
// Size: 0x24
function autoexec init_female_spawn() {
    level.female_percent = 0;
    set_female_percent(30);
}

// Namespace spawner
// Params 1, eflags: 0x1 linked
// Checksum 0x8727635b, Offset: 0x8e00
// Size: 0x18
function set_female_percent(percent) {
    level.female_percent = percent;
}

