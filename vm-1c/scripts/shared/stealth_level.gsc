#using scripts/codescripts/struct;
#using scripts/shared/ai_shared;
#using scripts/shared/ai_sniper_shared;
#using scripts/shared/array_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/stealth;
#using scripts/shared/stealth_actor;
#using scripts/shared/stealth_aware;
#using scripts/shared/stealth_debug;
#using scripts/shared/stealth_player;
#using scripts/shared/stealth_vo;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;

#namespace stealth_level;

// Namespace stealth_level
// Params 0, eflags: 0x0
// Checksum 0xb976633a, Offset: 0x3c0
// Size: 0x39c
function init() {
    assert(!isdefined(self.stealth));
    if (!isdefined(self.stealth)) {
        self.stealth = spawnstruct();
    }
    self.stealth.var_3206367b = 1;
    self.stealth.enemies = [];
    self.stealth.var_21c68c49 = [];
    self.stealth.var_21c68c49["unaware"] = 0;
    self.stealth.var_21c68c49["low_alert"] = 1;
    self.stealth.var_21c68c49["high_alert"] = 1;
    self.stealth.var_21c68c49["combat"] = 2;
    level flag::init("stealth_alert", 0);
    level flag::init("stealth_combat", 0);
    level flag::init("stealth_discovered", 0);
    function_cc5cb8a3();
    spawner::add_global_spawn_function("axis", &stealth::agent_init);
    self stealth_vo::init();
    self thread function_7bf2f7ba();
    self thread function_3cc2fee1();
    self thread function_a3cf57bf();
    self thread function_f8b0594a();
    self thread stealth_music_thread();
    self thread function_945a718();
    /#
        self stealth_debug::init_debug();
    #/
    level.var_d28aaa95 = 1;
    setdvar("ai_stumbleSightRange", -56);
    setdvar("ai_awarenessenabled", 1);
    setdvar("stealth_display", 0);
    setdvar("stealth_audio", 1);
    if (getdvarstring("stealth_indicator") == "") {
        setdvar("stealth_indicator", 0);
    }
    setdvar("stealth_group_radius", 1000);
    setdvar("stealth_all_aware", 1);
    setdvar("stealth_no_return", 1);
    setdvar("stealth_events", "sentientevents_vengeance_default");
}

// Namespace stealth_level
// Params 0, eflags: 0x0
// Checksum 0xe32edad7, Offset: 0x768
// Size: 0x142
function stop() {
    spawner::remove_global_spawn_function("axis", &stealth::agent_init);
    level.var_d28aaa95 = 0;
    setdvar("ai_stumbleSightRange", 0);
    setdvar("ai_awarenessenabled", 0);
    if (isdefined(level.stealth.music_ent)) {
        foreach (ent in level.stealth.music_ent) {
            ent stoploopsound(1);
            ent util::deleteaftertime(1.5);
        }
        level.stealth.music_ent = undefined;
    }
}

// Namespace stealth_level
// Params 0, eflags: 0x0
// Checksum 0x324c4859, Offset: 0x8b8
// Size: 0x7c
function reset() {
    level flag::clear("stealth_alert");
    level flag::clear("stealth_combat");
    level flag::clear("stealth_discovered");
    self thread function_f8b0594a();
}

// Namespace stealth_level
// Params 0, eflags: 0x0
// Checksum 0x751511a5, Offset: 0x940
// Size: 0x20
function enabled() {
    return isdefined(self.stealth) && isdefined(self.stealth.var_3206367b);
}

// Namespace stealth_level
// Params 0, eflags: 0x0
// Checksum 0x4874fa84, Offset: 0x968
// Size: 0x3fc
function function_cc5cb8a3() {
    assert(self enabled());
    if (!isdefined(self.stealth.var_1118b447)) {
        self.stealth.var_1118b447 = spawnstruct();
    }
    self.stealth.var_1118b447.awareness["unaware"] = spawnstruct();
    self.stealth.var_1118b447.awareness["low_alert"] = spawnstruct();
    self.stealth.var_1118b447.awareness["high_alert"] = spawnstruct();
    self.stealth.var_1118b447.awareness["combat"] = spawnstruct();
    vals = self.stealth.var_1118b447.awareness["unaware"];
    vals.fovcosine = cos(45);
    vals.fovcosinez = cos(10);
    vals.maxsightdist = 600;
    setstealthsight("unaware", 4, 0.5, 5, 100, 600, 0);
    vals = self.stealth.var_1118b447.awareness["low_alert"];
    vals.fovcosine = cos(60);
    vals.fovcosinez = cos(20);
    vals.maxsightdist = 800;
    setstealthsight("low_alert", 0, 0, 1, 100, 800, 0);
    vals = self.stealth.var_1118b447.awareness["high_alert"];
    vals.fovcosine = cos(60);
    vals.fovcosinez = cos(20);
    vals.maxsightdist = 1000;
    setstealthsight("high_alert", 16, 0.25, 4, 100, 1000, 0);
    vals = self.stealth.var_1118b447.awareness["combat"];
    vals.fovcosine = 0;
    vals.fovcosinez = 0;
    vals.maxsightdist = 8192;
    setstealthsight("combat", 32, 0.01, 0.01, 100, 1500, 1);
}

// Namespace stealth_level
// Params 1, eflags: 0x0
// Checksum 0xd5d10691, Offset: 0xd70
// Size: 0x48
function function_b3269823(var_5a51d1) {
    assert(isdefined(level.stealth));
    return level.stealth.var_1118b447.awareness[var_5a51d1];
}

// Namespace stealth_level
// Params 0, eflags: 0x0
// Checksum 0xd9733856, Offset: 0xdc0
// Size: 0x84
function function_7bf2f7ba() {
    array::thread_all(getentarray("_stealth_shadow", "targetname"), &function_49a3f37d);
    array::thread_all(getentarray("stealth_shadow", "targetname"), &function_49a3f37d);
}

// Namespace stealth_level
// Params 0, eflags: 0x0
// Checksum 0x72c7abbc, Offset: 0xe50
// Size: 0xb0
function function_49a3f37d() {
    self endon(#"death");
    while (true) {
        self waittill(#"trigger", other);
        if (!isalive(other)) {
            continue;
        }
        if (isdefined(other.stealth.in_shadow) && (!isdefined(other.stealth) || other.stealth.in_shadow)) {
            continue;
        }
        other thread function_9f3c4fa(self);
    }
}

// Namespace stealth_level
// Params 1, eflags: 0x0
// Checksum 0x1e8d875c, Offset: 0xf08
// Size: 0x80
function function_9f3c4fa(volume) {
    self endon(#"death");
    if (!isdefined(self.stealth)) {
        return;
    }
    self.stealth.in_shadow = 1;
    while (isdefined(volume) && self istouching(volume)) {
        wait 0.05;
    }
    self.stealth.in_shadow = 0;
}

// Namespace stealth_level
// Params 0, eflags: 0x0
// Checksum 0x513c5eea, Offset: 0xf90
// Size: 0xd4
function function_3cc2fee1() {
    assert(self enabled());
    self endon(#"stop_stealth");
    while (true) {
        self function_c66a9b53();
        sentientevents = getdvarstring("stealth_events");
        if (!isdefined(level.var_1e44252f) || sentientevents != "" && level.var_1e44252f != sentientevents) {
            loadsentienteventparameters(sentientevents);
        }
        level.var_1e44252f = sentientevents;
        wait 0.25;
    }
}

// Namespace stealth_level
// Params 0, eflags: 0x0
// Checksum 0x1c0c85b2, Offset: 0x1070
// Size: 0x79c
function function_c66a9b53() {
    assert(self enabled());
    self.stealth.enemies["axis"] = [];
    self.stealth.enemies["allies"] = [];
    self.stealth.seek = [];
    playerlist = getplayers();
    var_68e8737f = getaiarray();
    foreach (player in playerlist) {
        if (!isdefined(player.stealth)) {
            player stealth::agent_init();
        }
        if (isdefined(player.ignoreme) && player.ignoreme) {
            continue;
        }
        if (player.team == "allies") {
            self.stealth.enemies["axis"][player getentitynumber()] = player;
        }
        player stealth_player::function_b9393d6c("high_alert");
        player.stealth.incombat = 0;
    }
    var_c750f946 = 0;
    level.var_354c1bca = 0;
    level.stealth.var_e7ad9c1f = 0;
    foreach (ai in var_68e8737f) {
        if (isdefined(ai.ignoreme) && ai.ignoreme) {
            continue;
        }
        entnum = ai getentitynumber();
        counted = 0;
        if (isalive(ai) && ai stealth_aware::enabled() && !(isdefined(ai.silenced) && ai.silenced)) {
            var_96b139a9 = isactor(ai) && ai_sniper::is_firing(ai) && isdefined(ai.var_9eb700da) && isplayer(ai.var_9eb700da.var_8722cfb);
            if (!(isdefined(ai.ignoreall) && ai.ignoreall) && ai stealth_aware::function_739525d() != "unaware") {
                var_c750f946 += 1;
            }
            if (ai stealth_aware::function_739525d() == "combat" || var_96b139a9) {
                if (var_96b139a9) {
                    ai.stealth.var_d1b49f30[ai.var_9eb700da.var_8722cfb getentitynumber()] = ai.var_9eb700da.var_8722cfb;
                }
                counted = 0;
                if (isdefined(ai.stealth.var_d1b49f30)) {
                    foreach (combatant in ai.stealth.var_d1b49f30) {
                        if (!isalive(combatant)) {
                            continue;
                        }
                        var_146dd427 = combatant getentitynumber();
                        if (!isdefined(self.stealth.seek[var_146dd427])) {
                            self.stealth.seek[var_146dd427] = combatant;
                        }
                        if (isplayer(combatant)) {
                            if (!counted && !(isdefined(ai.ignoreall) && ai.ignoreall)) {
                                level.var_354c1bca += 1;
                                counted = 1;
                            }
                            combatant stealth_player::function_b9393d6c("combat");
                            if (!combatant.stealth.incombat) {
                                level.stealth.var_e7ad9c1f++;
                            }
                            combatant.stealth.incombat = 1;
                        }
                    }
                }
            }
        }
        if (ai.team == "allies") {
            self.stealth.enemies["axis"][entnum] = ai;
            continue;
        }
        if (ai.team == "axis") {
            self.stealth.enemies["allies"][entnum] = ai;
        }
    }
    if (var_c750f946 > 0) {
        level flag::set("stealth_alert");
    } else {
        level flag::clear("stealth_alert");
    }
    if (level.var_354c1bca > 0) {
        level flag::set("stealth_combat");
        return;
    }
    level flag::clear("stealth_combat");
}

// Namespace stealth_level
// Params 0, eflags: 0x0
// Checksum 0x4614a380, Offset: 0x1818
// Size: 0x120
function function_a3cf57bf() {
    self endon(#"stop_stealth");
    grace_period = 6;
    while (true) {
        level flag::wait_till("stealth_combat");
        if (level.stealth.var_e7ad9c1f == 0) {
            wait 0.05;
            continue;
        }
        level.stealth.var_30d9fcc6 = 1;
        wait grace_period;
        level.stealth.var_30d9fcc6 = 0;
        if (flag::get("stealth_combat")) {
            level flag::set("stealth_discovered");
            thread wake_all();
        }
        level flag::wait_till_clear("stealth_combat");
        if (isdefined(level.var_354c1bca)) {
            level.var_354c1bca = 0;
        }
    }
}

// Namespace stealth_level
// Params 0, eflags: 0x0
// Checksum 0xcdaf5bee, Offset: 0x1940
// Size: 0x260
function function_f8b0594a() {
    self notify(#"hash_f8b0594a");
    self endon(#"hash_f8b0594a");
    self endon(#"stop_stealth");
    while (true) {
        level flag::wait_till("stealth_alert");
        level flag::wait_till_clear("stealth_alert");
        wait randomfloatrange(1.5, 3);
        var_c6d0ac06 = isdefined(level.stealth.var_30d9fcc6) && isdefined(level.stealth) && level.stealth.var_30d9fcc6;
        while (isdefined(level.stealth.var_30d9fcc6) && isdefined(level.stealth) && level.stealth.var_30d9fcc6) {
            wait 0.05;
        }
        if (!level flag::get("stealth_alert") && !level flag::get("stealth_discovered") && !level flag::get("stealth_combat")) {
            foreach (player in level.activeplayers) {
                if (player stealth_player::enabled()) {
                    if (var_c6d0ac06) {
                        player stealth_vo::function_e3ae87b3("close_call");
                        continue;
                    }
                    player stealth_vo::function_e3ae87b3("returning");
                }
            }
        }
        wait randomfloatrange(1.5, 3);
    }
}

// Namespace stealth_level
// Params 0, eflags: 0x0
// Checksum 0xa1f9be49, Offset: 0x1ba8
// Size: 0x282
function wake_all() {
    self notify(#"wake_all");
    self endon(#"wake_all");
    if (getdvarint("stealth_no_return")) {
        enemies = getaiteamarray("axis");
        foreach (enemy in enemies) {
            if (!isalive(enemy)) {
                continue;
            }
            if (isdefined(enemy.stealth)) {
                enemy notify(#"wake_all");
                enemy notify(#"alert", "combat", enemy.origin, undefined, "wake_all");
                enemy stealth::stop();
            }
            foreach (player in level.activeplayers) {
                enemy getperfectinfo(player, 1);
            }
            enemy stopanimscripted();
            if (isdefined(enemy.patroller) && enemy.patroller) {
                enemy ai::end_and_clean_patrol_behaviors();
            }
            enemy ai_sniper::function_782962c5();
            if (isactor(enemy)) {
                enemy thread stealth_actor::function_1064f733();
            }
            wait 0.25;
        }
    }
}

// Namespace stealth_level
// Params 0, eflags: 0x0
// Checksum 0x262d9ca, Offset: 0x1e38
// Size: 0xe8
function stealth_music_thread() {
    self endon(#"stop_stealth");
    stealth::function_862e861f();
    while (true) {
        if (!level flag::get("stealth_discovered")) {
            if (level flag::get("stealth_combat")) {
                stealth::function_e0319e51("combat");
            } else if (level flag::get("stealth_alert")) {
                stealth::function_e0319e51("high_alert");
            } else {
                stealth::function_e0319e51("unaware");
            }
        }
        wait 0.05;
    }
}

// Namespace stealth_level
// Params 0, eflags: 0x0
// Checksum 0xc9e92ea9, Offset: 0x1f28
// Size: 0x2da
function function_945a718() {
    wait 0.05;
    var_e3fe91b2 = struct::get_array("stealth_callout", "targetname");
    foreach (ent in var_e3fe91b2) {
        ent stealth_vo::function_4970c8b8(ent.script_parameters);
    }
    var_e3fe91b2 = struct::get_array("stealth_callout", "script_noteworthy");
    foreach (ent in var_e3fe91b2) {
        ent stealth_vo::function_4970c8b8(ent.script_parameters);
    }
    var_e3fe91b2 = getentarray("stealth_callout", "targetname");
    foreach (ent in var_e3fe91b2) {
        ent stealth_vo::function_4970c8b8(ent.script_parameters);
    }
    var_e3fe91b2 = getentarray("stealth_callout", "script_noteworthy");
    foreach (ent in var_e3fe91b2) {
        ent stealth_vo::function_4970c8b8(ent.script_parameters);
    }
}

