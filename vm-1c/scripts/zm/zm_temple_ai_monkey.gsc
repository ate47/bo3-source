#using scripts/zm/_zm_ai_monkey;
#using scripts/zm/_zm_weap_shrink_ray;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_net;
#using scripts/zm/_zm_blockers;
#using scripts/zm/_zm_audio;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/zombie_shared;
#using scripts/shared/ai/zombie_death;
#using scripts/shared/ai/zombie;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/systems/animation_state_machine_notetracks;
#using scripts/shared/ai/systems/ai_interface;
#using scripts/shared/ai/archetype_utility;
#using scripts/shared/util_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/shared/animation_shared;
#using scripts/codescripts/struct;

#using_animtree("critter");

#namespace namespace_cafc107d;

// Namespace namespace_cafc107d
// Params 0, eflags: 0x2
// Checksum 0x2f097df8, Offset: 0xac0
// Size: 0x44
function autoexec function_dafa313c() {
    clientfield::register("scriptmover", "monkey_ragdoll", 21000, 1, "int");
    function_1444ad65();
}

// Namespace namespace_cafc107d
// Params 0, eflags: 0x5 linked
// Checksum 0xc8165d87, Offset: 0xb10
// Size: 0x54
function private function_1444ad65() {
    behaviortreenetworkutility::registerbehaviortreescriptapi("templeMonkeyTargetService", &function_a5409137);
    behaviortreenetworkutility::registerbehaviortreescriptapi("templeMonkeyDeathStart", &function_ff029657);
}

// Namespace namespace_cafc107d
// Params 1, eflags: 0x5 linked
// Checksum 0xd19aac9e, Offset: 0xb70
// Size: 0x10
function private function_a5409137(entity) {
    return true;
}

// Namespace namespace_cafc107d
// Params 1, eflags: 0x5 linked
// Checksum 0x83574584, Offset: 0xb88
// Size: 0x52
function private function_ff029657(entity) {
    if (isdefined(entity.var_325043ea)) {
        entity.var_325043ea.claimed = 0;
        level notify(#"powerup_dropped", entity.var_325043ea);
    }
}

// Namespace namespace_cafc107d
// Params 0, eflags: 0x1 linked
// Checksum 0xb406ca32, Offset: 0xbe8
// Size: 0x1f4
function init() {
    function_c39787b6();
    level._effect["monkey_death"] = "maps/zombie/fx_zmb_monkey_death";
    level._effect["monkey_spawn"] = "maps/zombie/fx_zombie_ape_spawn_dust";
    level._effect["monkey_eye_glow"] = "maps/zombie/fx_zmb_monkey_eyes";
    level._effect["monkey_gib"] = "maps/zombie_temple/fx_ztem_zombie_mini_squish";
    level._effect["monkey_gib_no_gore"] = "dlc5/temple/fx_ztem_monkey_shrink";
    level._effect["monkey_launch"] = "weapon/fx_trail_rpg";
    level.var_7e34a7d9 = getentarray("monkey_zombie_spawner", "targetname");
    level.var_51f8a74a = 1;
    level.var_a6670dd8 = level.zombie_vars["zombie_health_start"];
    level.var_79b93748 = struct::get_array("stealer_monkey_spawn", "targetname");
    level.var_dc8401f = struct::get_array("stealer_monkey_exit", "targetname");
    /#
        cheat = getdvarint("monkey_spawn");
        if (cheat) {
            level.var_51f8a74a = 1;
        }
    #/
    level thread function_ad96bb7f();
    level thread function_c6478283();
    function_316b0a64();
    level thread function_f4fbd6b0();
}

// Namespace namespace_cafc107d
// Params 0, eflags: 0x1 linked
// Checksum 0x47e93861, Offset: 0xde8
// Size: 0x3c
function function_f4fbd6b0() {
    level flag::wait_till("initial_players_connected");
    level thread namespace_8fb880d9::function_ca38df4c();
}

// Namespace namespace_cafc107d
// Params 1, eflags: 0x0
// Checksum 0x2143c89d, Offset: 0xe30
// Size: 0x24
function function_6d81efca(spawner) {
    self thread function_ade5bbf8(spawner);
}

// Namespace namespace_cafc107d
// Params 3, eflags: 0x1 linked
// Checksum 0xf0943f5f, Offset: 0xe60
// Size: 0x304
function function_490217d0(mindist, var_be531137, var_355d1723) {
    var_4a0c645a = [];
    var_a0a04847 = [];
    var_de4ee045 = self function_b9d071cd();
    var_a0a04847[0] = var_de4ee045;
    var_ff630891 = 0;
    while (var_a0a04847.size > 0) {
        var_ff630891++;
        var_833e822b = var_a0a04847[0];
        zone = level.zones[var_833e822b];
        if (!var_355d1723 || isdefined(zone.barriers) && var_de4ee045 != var_833e822b) {
            barriers = function_ee9f00c5(zone.barriers);
            for (i = 0; i < barriers.size; i++) {
                text = "Zone: " + var_ff630891 + " Barrier: " + i;
                if (barriers[i] function_c912fd5(zone, self, mindist, var_be531137)) {
                    location = function_2d0fbe55(barriers[i]);
                    return location;
                }
            }
        }
        var_4a0c645a[var_4a0c645a.size] = var_833e822b;
        arrayremoveindex(var_a0a04847, 0);
        azkeys = getarraykeys(zone.adjacent_zones);
        azkeys = function_ee9f00c5(azkeys);
        for (i = 0; i < azkeys.size; i++) {
            name = azkeys[i];
            if (!isinarray(var_4a0c645a, name)) {
                var_7b1275d2 = zone.adjacent_zones[name];
                var_318c75f6 = level.zones[name];
                if (var_7b1275d2.is_connected && var_318c75f6.is_enabled) {
                    var_a0a04847[var_a0a04847.size] = name;
                }
            }
        }
    }
    return undefined;
}

// Namespace namespace_cafc107d
// Params 4, eflags: 0x1 linked
// Checksum 0x6b4a293a, Offset: 0x1170
// Size: 0x190
function function_c912fd5(zone, ent, mindist, var_be531137) {
    if (!zone.is_active) {
        return true;
    }
    var_4e9a6777 = mindist * mindist;
    var_bca12e13 = distancesquared(ent.origin, self.origin);
    if (var_bca12e13 < var_4e9a6777) {
        return false;
    }
    if (var_be531137) {
        var_b9dc1790 = 1800;
        var_510718d2 = var_b9dc1790 * var_b9dc1790;
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            player = players[i];
            var_abf8fb79 = distancesquared(player.origin, self.origin);
            if (var_abf8fb79 < var_510718d2) {
                if (self player_can_see_me(player)) {
                    return false;
                }
            }
        }
    }
    return true;
}

// Namespace namespace_cafc107d
// Params 3, eflags: 0x1 linked
// Checksum 0xbe00dfde, Offset: 0x1308
// Size: 0x1fe
function function_f593d568(var_1b4b9af, var_a695ca1b, var_8434b443) {
    var_76b379ac = [];
    var_bdaf8138 = var_1b4b9af;
    if (!isdefined(var_bdaf8138)) {
        var_bdaf8138 = self function_b9d071cd();
    }
    if (isdefined(var_bdaf8138)) {
        s = spawnstruct();
        zonenames = function_23f5c009(var_bdaf8138, s);
        players = getplayers();
        for (i = 0; i < zonenames.size; i++) {
            name = zonenames[i];
            zone = level.zones[name];
            if (isdefined(var_a695ca1b) && var_a695ca1b && zone.is_occupied) {
                continue;
            }
            barriers = [];
            if (isdefined(var_8434b443) && var_8434b443) {
                barriers = function_d5d87c4a(zone.barriers);
            } else if (isdefined(zone.barriers)) {
                barriers = zone.barriers;
            }
            if (barriers.size > 0) {
                var_76b379ac = arraycombine(var_76b379ac, barriers, 0, 0);
            }
        }
    }
    return var_76b379ac;
}

// Namespace namespace_cafc107d
// Params 2, eflags: 0x0
// Checksum 0x1e5d3abb, Offset: 0x1510
// Size: 0x188
function function_48b7f63f(text, red) {
    level endon(#"hash_7819cf45");
    if (!isdefined(level.var_accf4eb2)) {
        level.var_accf4eb2 = [];
    }
    originstr = "(" + self.origin[0] + "," + self.origin[1] + "," + self.origin[2] + ")";
    if (!isdefined(level.var_accf4eb2[originstr])) {
        level.var_accf4eb2[originstr] = (0, 0, 0);
    } else {
        level.var_accf4eb2[originstr] = level.var_accf4eb2[originstr] + (0, 0, 20);
    }
    offset = (0, 0, 45) + level.var_accf4eb2[originstr];
    color = (0, 1, 0);
    if (isdefined(red) && red) {
        color = (1, 0, 0);
    }
    while (true) {
        /#
            print3d(self.origin + offset, text, color, 0.85);
        #/
        wait(0.05);
    }
}

// Namespace namespace_cafc107d
// Params 0, eflags: 0x0
// Checksum 0x995768ab, Offset: 0x16a0
// Size: 0x1c
function function_c66ea29f() {
    level notify(#"hash_7819cf45");
    level.var_accf4eb2 = [];
}

// Namespace namespace_cafc107d
// Params 1, eflags: 0x1 linked
// Checksum 0xe30ad362, Offset: 0x16c8
// Size: 0x154
function function_d5d87c4a(barriers) {
    var_bf840ad3 = [];
    if (isdefined(barriers)) {
        players = getplayers();
        for (i = 0; i < barriers.size; i++) {
            cansee = 0;
            for (j = 0; j < players.size; j++) {
                if (abs(barriers[i].origin[2] - players[j].origin[2]) < -56) {
                    if (barriers[i] player_can_see_me(players[j])) {
                        cansee = 1;
                        break;
                    }
                }
            }
            if (!cansee) {
                var_bf840ad3[var_bf840ad3.size] = barriers[i];
            }
        }
    }
    return var_bf840ad3;
}

// Namespace namespace_cafc107d
// Params 1, eflags: 0x1 linked
// Checksum 0xe24e9c6d, Offset: 0x1828
// Size: 0x1c0
function player_can_see_me(player) {
    playerangles = player getplayerangles();
    playerforwardvec = anglestoforward(playerangles);
    playerunitforwardvec = vectornormalize(playerforwardvec);
    banzaipos = self.origin;
    playerpos = player geteyeapprox();
    playertobanzaivec = banzaipos - playerpos;
    playertobanzaiunitvec = vectornormalize(playertobanzaivec);
    forwarddotbanzai = vectordot(playerunitforwardvec, playertobanzaiunitvec);
    anglefromcenter = acos(forwarddotbanzai);
    playerfov = getdvarfloat("cg_fov");
    banzaivsplayerfovbuffer = getdvarfloat("g_banzai_player_fov_buffer");
    if (banzaivsplayerfovbuffer <= 0) {
        banzaivsplayerfovbuffer = 0.2;
    }
    var_ad758dfb = anglefromcenter <= playerfov * 0.5 * (1 - banzaivsplayerfovbuffer);
    return var_ad758dfb;
}

// Namespace namespace_cafc107d
// Params 2, eflags: 0x0
// Checksum 0xdf42307c, Offset: 0x19f0
// Size: 0x58
function function_16882cf8(loc, color) {
    while (true) {
        /#
            circle(loc, 16, color, 0, 1, 800);
        #/
        wait(0.05);
    }
}

// Namespace namespace_cafc107d
// Params 1, eflags: 0x1 linked
// Checksum 0xa514484, Offset: 0x1a50
// Size: 0x84
function function_2d0fbe55(barrier) {
    forward = anglestoforward(barrier.angles);
    var_62be288d = barrier.origin + forward * 80;
    var_62be288d = getclosestpointonnavmesh(var_62be288d, -56);
    return var_62be288d;
}

// Namespace namespace_cafc107d
// Params 0, eflags: 0x0
// Checksum 0xd321cacc, Offset: 0x1ae0
// Size: 0x44
function function_f65a45ec() {
    zonename = self function_b9d071cd();
    if (isdefined(zonename)) {
        return level.zones[zonename];
    }
    return undefined;
}

// Namespace namespace_cafc107d
// Params 0, eflags: 0x1 linked
// Checksum 0xc8b17919, Offset: 0x1b30
// Size: 0xfc
function function_b9d071cd() {
    zkeys = getarraykeys(level.zones);
    for (z = 0; z < zkeys.size; z++) {
        zonename = zkeys[z];
        zone = level.zones[zonename];
        for (v = 0; v < zone.volumes.size; v++) {
            touching = self istouching(zone.volumes[v]);
            if (touching) {
                return zonename;
            }
        }
    }
    return undefined;
}

// Namespace namespace_cafc107d
// Params 0, eflags: 0x1 linked
// Checksum 0xd0dbac82, Offset: 0x1c38
// Size: 0x1e4
function function_ad96bb7f() {
    wait(1);
    var_5c729982 = spawn("script_origin", (0, 0, 0));
    for (i = 0; i < level.exterior_goals.size; i++) {
        goal = level.exterior_goals[i];
        forward = anglestoforward(goal.angles);
        var_5c729982.origin = goal.origin + forward * 100;
        zonename = var_5c729982 function_b9d071cd();
        valid = isdefined(zonename) && isdefined(level.zones[zonename]);
        if (!valid) {
            /#
                iprintln("monkey_spawn" + var_5c729982.origin);
            #/
            continue;
        }
        goal.zonename = zonename;
        zone = level.zones[zonename];
        if (!isdefined(zone.barriers)) {
            zone.barriers = [];
        }
        zone.barriers[zone.barriers.size] = goal;
    }
    var_5c729982 delete();
}

// Namespace namespace_cafc107d
// Params 1, eflags: 0x1 linked
// Checksum 0x20b6862c, Offset: 0x1e28
// Size: 0xfc
function function_ade5bbf8(spawner) {
    self endon(#"death");
    spawner.count = 100;
    spawner.last_spawn_time = gettime();
    playfx(level._effect["monkey_death"], self.origin);
    playsoundatposition("zmb_bolt", self.origin);
    self.deathfunction = &function_25701b8e;
    self.spawnzone = spawner.script_noteworthy;
    self.var_7711e778 = &function_96fb0ddd;
    self thread function_5d40ea94();
    self thread function_94555914();
}

// Namespace namespace_cafc107d
// Params 1, eflags: 0x1 linked
// Checksum 0x8e70bc11, Offset: 0x1f30
// Size: 0x3c
function function_9375b409(moveplaybackrate) {
    self.zombie_move_speed = "run";
    self zombie_utility::set_zombie_run_cycle("run");
}

// Namespace namespace_cafc107d
// Params 1, eflags: 0x1 linked
// Checksum 0x2f967968, Offset: 0x1f78
// Size: 0x3c
function function_5d40ea94(moveplaybackrate) {
    self.zombie_move_speed = "sprint";
    self zombie_utility::set_zombie_run_cycle("sprint");
}

// Namespace namespace_cafc107d
// Params 8, eflags: 0x1 linked
// Checksum 0x3d4f36fc, Offset: 0x1fc0
// Size: 0x126
function function_25701b8e(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
    self zombie_utility::reset_attack_spot();
    self.grenadeammo = 0;
    self thread zombie_utility::zombie_eye_glow_stop();
    playfx(level._effect["monkey_death"], self.origin);
    if (isdefined(self.attacker) && isplayer(self.attacker)) {
        self.attacker zm_audio::create_and_play_dialog("kill", "thief");
    }
    if (self.damagemod == "MOD_BURNED") {
        self thread zombie_death::flame_death_fx();
    }
    return false;
}

// Namespace namespace_cafc107d
// Params 0, eflags: 0x1 linked
// Checksum 0xd277b31e, Offset: 0x20f0
// Size: 0x194
function function_94555914() {
    self endon(#"death");
    self endon(#"shrink");
    barriers = level.zones[self.spawnzone].barriers;
    if (!isdefined(barriers)) {
        barriers = [];
    }
    barriers = function_b5209717(barriers);
    for (i = 0; i < barriers.size; i++) {
        barrier = barriers[i];
        location = function_2d0fbe55(barrier);
        self.goalradius = 32;
        self setgoalpos(location);
        self waittill(#"goal");
        self setgoalpos(self.origin);
        while (true) {
            chunk = function_5dae2913(barrier.barrier_chunks);
            if (!isdefined(chunk)) {
                break;
            }
            self function_82d978bf(barrier, chunk, location);
        }
    }
    self function_38519f2();
}

// Namespace namespace_cafc107d
// Params 1, eflags: 0x1 linked
// Checksum 0x1e9dcd37, Offset: 0x2290
// Size: 0x98
function function_5dae2913(barrier_chunks) {
    assert(isdefined(barrier_chunks), "monkey_spawn");
    for (i = 0; i < barrier_chunks.size; i++) {
        if (barrier_chunks[i] zm_utility::get_chunk_state() == "repaired") {
            return barrier_chunks[i];
        }
    }
    return undefined;
}

// Namespace namespace_cafc107d
// Params 3, eflags: 0x1 linked
// Checksum 0x7d74ef5a, Offset: 0x2330
// Size: 0x1ba
function function_82d978bf(barrier, chunk, location) {
    chunk zm_blockers::update_states("target_by_zombie");
    self teleport(location, self.angles);
    time = self getanimlengthfromasd("zm_attack_perks_front", 0);
    self thread namespace_8fb880d9::function_75ae4f3e(time);
    zombie_shared::donotetracks("attack_perks_front");
    playfx(level._effect["wood_chunk_destory"], chunk.origin);
    if (chunk.script_noteworthy == "4" || chunk.script_noteworthy == "6") {
        chunk thread zm_spawner::zombie_boardtear_offset_fx_horizontle(chunk, barrier);
    } else {
        chunk thread zm_spawner::zombie_boardtear_offset_fx_verticle(chunk, barrier);
    }
    level thread zm_blockers::remove_chunk(chunk, barrier, 1, self);
    chunk zm_blockers::update_states("destroyed");
    chunk notify(#"destroyed");
    wait(time);
}

// Namespace namespace_cafc107d
// Params 1, eflags: 0x1 linked
// Checksum 0x542d9b90, Offset: 0x24f8
// Size: 0x10
function function_b5209717(barriers) {
    return barriers;
}

// Namespace namespace_cafc107d
// Params 0, eflags: 0x1 linked
// Checksum 0x18dc800c, Offset: 0x2510
// Size: 0xc8
function function_c6478283() {
    if (!isdefined(level.var_7e34a7d9) || level.var_7e34a7d9.size == 0) {
        return;
    }
    while (true) {
        powerup = level waittill(#"powerup_dropped");
        if (!isdefined(powerup)) {
            continue;
        }
        if (level.round_number < level.var_51f8a74a) {
            continue;
        }
        wait(randomfloatrange(0, 1));
        if (function_2a676f74(powerup)) {
            function_120f4737(powerup);
        }
    }
}

// Namespace namespace_cafc107d
// Params 1, eflags: 0x1 linked
// Checksum 0xeb0aac2, Offset: 0x25e0
// Size: 0x38
function function_2a676f74(powerup) {
    return !isdefined(powerup.claimed) || isdefined(powerup) && !powerup.claimed;
}

// Namespace namespace_cafc107d
// Params 1, eflags: 0x1 linked
// Checksum 0x7cc7ddba, Offset: 0x2620
// Size: 0x258
function function_120f4737(powerup) {
    spawner = level.var_7e34a7d9[0];
    monkey = zombie_utility::spawn_zombie(spawner);
    if (!isdefined(monkey)) {
        return;
    }
    level.var_51f8a74a = 1;
    /#
        cheat = getdvarint("monkey_spawn");
        if (cheat) {
            level.var_51f8a74a = 1;
        }
    #/
    monkey.ignore_enemy_count = 1;
    monkey.meleedamage = 10;
    monkey.custom_damage_func = &function_187afb04;
    location = monkey function_bba2e43a(powerup);
    monkey forceteleport(location, monkey.angles);
    monkey.deathfunction = &function_7b7753a1;
    monkey.var_7711e778 = &function_96fb0ddd;
    monkey.var_21c0c94c = &function_5e58815d;
    monkey.var_b85ae18c = 0;
    monkey.ignore_solo_last_stand = 1;
    spawner.count = 100;
    spawner.last_spawn_time = gettime();
    monkey thread function_5d40ea94();
    monkey.var_325043ea = powerup;
    monkey thread function_b0b5ea7a();
    monkey thread function_cfcf9d1f();
    monkey thread function_e686e2af();
    monkey thread function_9bb734c9();
    monkey.zombie_think_done = 1;
}

// Namespace namespace_cafc107d
// Params 0, eflags: 0x1 linked
// Checksum 0x176b5b85, Offset: 0x2880
// Size: 0x50
function function_4e62c5f7() {
    self endon(#"death");
    self endon(#"powerup_dropped");
    while (true) {
        playsoundatposition("zmb_stealer_stolen", self.origin);
        wait(0.845);
    }
}

// Namespace namespace_cafc107d
// Params 1, eflags: 0x1 linked
// Checksum 0xeacab488, Offset: 0x28d8
// Size: 0xc4
function function_bba2e43a(e_powerup) {
    var_9199584e = self function_490217d0(700, 0, 1);
    if (!isdefined(var_9199584e)) {
        var_9199584e = self function_490217d0(700, 1, 0);
    }
    if (!isdefined(var_9199584e)) {
        var_9199584e = self function_490217d0(0, 0, 0);
    }
    if (!isdefined(var_9199584e) && isdefined(e_powerup)) {
        var_9199584e = function_2d0fbe55(e_powerup);
    }
    return var_9199584e;
}

// Namespace namespace_cafc107d
// Params 0, eflags: 0x1 linked
// Checksum 0xd66c5f06, Offset: 0x29a8
// Size: 0x9c
function function_9bb734c9() {
    self endon(#"death");
    self endon(#"hash_3ed54e9c");
    self function_4155fdf4();
    if (!isdefined(self.powerup) && !(isdefined(self.attack_player) && self.attack_player)) {
        self function_3bd5290b();
    }
    self thread function_ed197e19();
    self function_52f2c4cf();
}

// Namespace namespace_cafc107d
// Params 0, eflags: 0x1 linked
// Checksum 0x176e26c9, Offset: 0x2a50
// Size: 0xfc
function function_ed197e19() {
    self notify(#"hash_e2a515e6");
    self endon(#"hash_e2a515e6");
    self endon(#"hash_bd54fd6a");
    self endon(#"death");
    self waittill(#"bad_path");
    self notify(#"hash_3ed54e9c");
    self.var_a6542123 = 0;
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        if (zombie_utility::is_player_valid(players[i])) {
            self.var_c3ff696c = players[i];
        }
    }
    self function_3bd5290b();
    self thread function_9bb734c9();
}

// Namespace namespace_cafc107d
// Params 0, eflags: 0x1 linked
// Checksum 0x11e9f4db, Offset: 0x2b58
// Size: 0x1cc
function function_4155fdf4() {
    if (isdefined(self.var_325043ea)) {
        self.goalradius = 16;
        var_f481d194 = getclosestpointonnavmesh(self.var_325043ea.origin, -56);
        self setgoalpos(var_f481d194);
        self function_5933fd4d();
    }
    if (function_2a676f74(self.var_325043ea)) {
        self function_9375b409();
        self.var_325043ea show();
        self function_71ffac8d(self.var_325043ea);
        self.powerup = self.var_325043ea;
        self.var_325043ea = undefined;
        if (isdefined(self.powerup.var_f304fb0f)) {
            self.powerup.var_f304fb0f++;
        } else {
            self.powerup.var_f304fb0f = 1;
        }
        self.powerup thread function_c5463ba7(self);
        self.powerup thread function_20ec5c50(self);
        self thread function_4e62c5f7();
        self.powerup.stolen = 1;
        self.powerup notify(#"powerup_grabbed");
        self thread function_45929770();
    }
}

// Namespace namespace_cafc107d
// Params 0, eflags: 0x1 linked
// Checksum 0x9947f194, Offset: 0x2d30
// Size: 0xb0
function function_45929770() {
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        if (distancesquared(self.origin, players[i].origin) <= 250000) {
            players[i] thread zm_audio::create_and_play_dialog("general", "thief_steal");
            return;
        }
    }
}

// Namespace namespace_cafc107d
// Params 0, eflags: 0x1 linked
// Checksum 0x561fce2e, Offset: 0x2de8
// Size: 0x3c
function function_5933fd4d() {
    self endon(#"goal");
    self.var_325043ea waittill(#"death");
    self.var_c3ff696c = self.var_325043ea.power_up_grab_player;
}

// Namespace namespace_cafc107d
// Params 1, eflags: 0x1 linked
// Checksum 0xb2673d07, Offset: 0x2e30
// Size: 0xdc
function function_c5463ba7(monkey) {
    monkey endon(#"death");
    self.var_3bfd5383 = zm_net::network_safe_spawn("monkey_red_powerup", 2, "script_model", self.origin);
    self.var_3bfd5383 setmodel("tag_origin");
    self.var_3bfd5383 linkto(self);
    playfxontag(level._effect["powerup_on_red"], self.var_3bfd5383, "tag_origin");
    self clientfield::set("powerup_fx", 3);
}

// Namespace namespace_cafc107d
// Params 0, eflags: 0x1 linked
// Checksum 0x423e6b8a, Offset: 0x2f18
// Size: 0x324
function function_52f2c4cf() {
    self endon(#"death");
    self endon(#"hash_3ed54e9c");
    self notify(#"stop_find_flesh");
    self.escaping = 1;
    self function_aaeace69();
    location = (0, 0, 0);
    angles = (0, 0, 0);
    var_7e2596a8 = 0;
    if (level.var_dc8401f.size > 0) {
        var_7e2596a8 = 1;
        var_20ce2d4b = array::random(level.var_dc8401f);
        location = var_20ce2d4b.origin;
        angles = var_20ce2d4b.angles;
    } else {
        var_911aeecc = self function_f593d568();
        maxdist = 0;
        var_db8c9404 = undefined;
        for (i = 0; i < var_911aeecc.size; i++) {
            dist2 = distancesquared(self.origin, var_911aeecc[i].origin);
            if (dist2 > maxdist) {
                maxdist = dist2;
                var_db8c9404 = var_911aeecc[i];
            }
        }
        location = function_2d0fbe55(var_db8c9404);
    }
    self.goalradius = 8;
    location = getclosestpointonnavmesh(location, -56);
    self setgoalpos(location);
    self waittill(#"goal");
    self notify(#"hash_bd54fd6a");
    if (var_7e2596a8) {
        if (!isdefined(angles)) {
            angles = (0, 0, 0);
        }
        var_92349448 = "rtrg_ai_zm_dlc5_monkey_pap_escape";
        time = getanimlength(var_92349448);
        self animscripted("escape_anim", self.origin, self.angles, var_92349448);
        wait(time);
    }
    var_acdfd9 = isdefined(self.powerup);
    if (var_acdfd9) {
        level notify(#"hash_f3707167");
    }
    level thread function_15285811(var_acdfd9);
    self function_38519f2();
}

// Namespace namespace_cafc107d
// Params 1, eflags: 0x1 linked
// Checksum 0xdf23e1c6, Offset: 0x3248
// Size: 0x74
function function_15285811(var_acdfd9) {
    if (!isdefined(level.var_5567bb80)) {
        level.var_5567bb80 = 0;
        level.var_1147282a = 0;
    }
    level.var_5567bb80++;
    if (var_acdfd9) {
        level.var_1147282a++;
    }
    if (level.var_1147282a % 5 == 0) {
        level thread function_e7af9290();
    }
}

// Namespace namespace_cafc107d
// Params 0, eflags: 0x1 linked
// Checksum 0xa9ee6bd7, Offset: 0x32c8
// Size: 0x12c
function function_e7af9290() {
    var_8d78a1c5 = spawn("script_model", (-24, 1448, 1000));
    if (isdefined(var_8d78a1c5)) {
        var_8d78a1c5 endon(#"death");
        var_8d78a1c5 setmodel("tag_origin");
        var_8d78a1c5.angles = (90, 0, 0);
        playfxontag(level._effect["monkey_launch"], var_8d78a1c5, "tag_origin");
        launchtime = 6;
        var_8d78a1c5 moveto(var_8d78a1c5.origin + (0, 0, 2500), launchtime, 3);
        wait(launchtime);
        var_8d78a1c5 delete();
    }
}

// Namespace namespace_cafc107d
// Params 0, eflags: 0x1 linked
// Checksum 0xa9d6105d, Offset: 0x3400
// Size: 0x170
function function_cfcf9d1f() {
    self endon(#"death");
    candamage = 1;
    areas = getentarray("player_volume", "script_noteworthy");
    while (true) {
        var_293dad5f = 0;
        for (i = 0; i < areas.size && !var_293dad5f; i++) {
            var_293dad5f = self istouching(areas[i]);
        }
        if (candamage && !var_293dad5f) {
            println("monkey_spawn");
            candamage = 0;
            self util::magic_bullet_shield();
        } else if (!candamage && var_293dad5f) {
            println("monkey_spawn");
            candamage = 1;
            self util::stop_magic_bullet_shield();
        }
        wait(0.2);
    }
}

// Namespace namespace_cafc107d
// Params 0, eflags: 0x1 linked
// Checksum 0x91a5a15e, Offset: 0x3578
// Size: 0x64
function function_e686e2af() {
    self endon(#"death");
    if (!isdefined(self.endtime)) {
        self.endtime = gettime() + 60000;
    }
    while (self.endtime > gettime()) {
        wait(0.5);
    }
    self function_38519f2();
}

// Namespace namespace_cafc107d
// Params 0, eflags: 0x1 linked
// Checksum 0xcdf54b17, Offset: 0x35e8
// Size: 0x18
function function_aaeace69() {
    self.endtime = gettime() + 60000;
}

// Namespace namespace_cafc107d
// Params 8, eflags: 0x1 linked
// Checksum 0x15b32224, Offset: 0x3608
// Size: 0x286
function function_7b7753a1(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
    self.grenadeammo = 0;
    playsoundatposition("zmb_stealer_death", self.origin);
    self thread zombie_utility::zombie_eye_glow_stop();
    if (isdefined(self.attacker) && isplayer(self.attacker)) {
        self.attacker zm_audio::create_and_play_dialog("kill", "thief");
        isfavoriteenemy = isdefined(self.favoriteenemy) && self.favoriteenemy == self.attacker;
        var_24743e96 = !isdefined(self.var_a6542123) || self.var_a6542123 == 0;
        if (isdefined(self.attacking_player) && self.attacking_player && var_24743e96 && isfavoriteenemy) {
            self.attacker zm_score::player_add_points("thundergun_fling", 500, (0, 0, 0), 0);
        }
    }
    if (isdefined(self.attacker) && isplayer(self.attacker)) {
        self.attacker zm_score::player_add_points("damage");
    }
    if (isdefined(self.powerup)) {
        self function_ca8890f0();
    }
    if ("rottweil72_upgraded_zm" == self.damageweapon.name && "MOD_RIFLE_BULLET" == self.damagemod) {
        self thread function_fd20eb();
    }
    if (isdefined(self.var_1bf7f0e2) && self.var_1bf7f0e2) {
        self thread function_f6eabea0();
        self util::delay(0.05, undefined, &zm_utility::self_delete);
    }
    return false;
}

// Namespace namespace_cafc107d
// Params 0, eflags: 0x1 linked
// Checksum 0xf9aa0d5d, Offset: 0x3898
// Size: 0x284
function function_fd20eb() {
    if (self.isdog) {
        return;
    }
    if (!isdefined(level._effect) || !isdefined(level._effect["character_fire_death_sm"])) {
        println("monkey_spawn");
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

// Namespace namespace_cafc107d
// Params 0, eflags: 0x1 linked
// Checksum 0x3705b379, Offset: 0x3b28
// Size: 0x1c2
function function_ca8890f0() {
    var_6dd914d9 = self.powerup;
    if (isdefined(self.powerup)) {
        self notify(#"powerup_dropped");
        self.powerup notify(#"hash_301e7805");
        if (isdefined(self.powerup.var_3bfd5383)) {
            self.powerup.var_3bfd5383 util::delay(0.1, undefined, &zm_utility::self_delete);
            self.powerup.var_3bfd5383 = undefined;
        }
        self.powerup.claimed = 0;
        level notify(#"powerup_dropped", self.powerup);
        origin = self.origin;
        if (isdefined(self.is_traversing) && self.is_traversing) {
            origin = zm_utility::groundpos(self.origin + (0, 0, 10));
        }
        origin += (0, 0, 40);
        self.powerup unlink();
        self.powerup.origin = origin;
        self.powerup thread zm_powerups::powerup_timeout();
        self.powerup thread zm_powerups::powerup_wobble();
        self.powerup thread zm_powerups::powerup_grab();
        self.powerup = undefined;
    }
    return var_6dd914d9;
}

// Namespace namespace_cafc107d
// Params 1, eflags: 0x1 linked
// Checksum 0x22cbe561, Offset: 0x3cf8
// Size: 0xcc
function function_38519f2(playfx) {
    self notify(#"remove");
    if (!isdefined(playfx)) {
        playfx = 1;
    }
    if (isdefined(self.powerup)) {
        if (isdefined(self.powerup.var_3bfd5383)) {
            self.powerup.var_3bfd5383 delete();
            self.powerup.var_3bfd5383 = undefined;
        }
        self.powerup zm_powerups::powerup_delete();
    }
    self thread zombie_utility::zombie_eye_glow_stop();
    self delete();
}

// Namespace namespace_cafc107d
// Params 2, eflags: 0x1 linked
// Checksum 0xd688fa7f, Offset: 0x3dd0
// Size: 0x1be
function function_23f5c009(zonename, params) {
    if (!isdefined(params.tested)) {
        params.tested = [];
    }
    ret = [];
    if (!isdefined(params.tested[zonename])) {
        ret[0] = zonename;
        params.tested[zonename] = 1;
        zone = level.zones[zonename];
        azkeys = getarraykeys(zone.adjacent_zones);
        for (i = 0; i < azkeys.size; i++) {
            name = azkeys[i];
            var_7b1275d2 = zone.adjacent_zones[name];
            var_318c75f6 = level.zones[name];
            if (var_7b1275d2.is_connected && var_318c75f6.is_enabled) {
                zonenames = function_23f5c009(name, params);
                ret = arraycombine(ret, zonenames, 0, 0);
            }
        }
    }
    return ret;
}

// Namespace namespace_cafc107d
// Params 1, eflags: 0x1 linked
// Checksum 0x4be5ae30, Offset: 0x3f98
// Size: 0x312
function function_20ec5c50(monkey) {
    self endon(#"hash_301e7805");
    monkey endon(#"remove");
    var_71a3a588 = array("carpenter", "fire_sale", "nuke", "double_points", "insta_kill");
    var_71a3a588 = function_ee9f00c5(var_71a3a588);
    var_71a3a588[var_71a3a588.size] = "full_ammo";
    if (level.chest_moves < 1) {
        arrayremovevalue(var_71a3a588, "fire_sale");
    }
    if (level.round_number <= 1) {
        arrayremovevalue(var_71a3a588, "nuke");
    }
    var_ff2a44d4 = undefined;
    keys = getarraykeys(level.zombie_powerups);
    for (i = 0; i < keys.size; i++) {
        if (level.zombie_powerups[keys[i]].model_name == self.model) {
            var_ff2a44d4 = keys[i];
            break;
        }
    }
    if (isdefined(var_ff2a44d4)) {
        arrayremovevalue(var_71a3a588, var_ff2a44d4);
        arrayinsert(var_71a3a588, var_ff2a44d4, 0);
    }
    if (var_ff2a44d4 == "full_ammo" && self.var_f304fb0f == 1) {
        index = randomintrange(1, var_71a3a588.size - 1);
        arrayinsert(var_71a3a588, "free_perk", index);
    }
    wait(1);
    index = 1;
    while (true) {
        powerupname = var_71a3a588[index];
        index++;
        if (index >= var_71a3a588.size) {
            index = 0;
        }
        self zm_powerups::powerup_setup(powerupname, undefined, undefined, undefined, 0);
        self playsound("zmb_temple_powerup_switch");
        monkey function_71ffac8d(self);
        if (powerupname == "free_perk") {
            wait(0.25);
            continue;
        }
        wait(1);
    }
}

// Namespace namespace_cafc107d
// Params 1, eflags: 0x1 linked
// Checksum 0x74814c20, Offset: 0x42b8
// Size: 0xa6
function function_ee9f00c5(array) {
    n = array.size;
    while (n > 0) {
        index = randomint(n);
        n -= 1;
        temp = array[index];
        array[index] = array[n];
        array[n] = temp;
    }
    return array;
}

// Namespace namespace_cafc107d
// Params 1, eflags: 0x1 linked
// Checksum 0x549d06dc, Offset: 0x4368
// Size: 0xa4
function function_71ffac8d(powerup) {
    powerup unlink();
    powerup.angles = self.angles;
    powerup.origin = self.origin;
    offset = (0, 0, 40);
    angles = (0, 0, 0);
    powerup linkto(self, "tag_origin", offset, angles);
}

// Namespace namespace_cafc107d
// Params 0, eflags: 0x1 linked
// Checksum 0x6e8d74e3, Offset: 0x4418
// Size: 0x4c
function function_f6eabea0() {
    playfx(level._effect["monkey_gib_no_gore"], self.origin);
    self ghost();
}

// Namespace namespace_cafc107d
// Params 1, eflags: 0x1 linked
// Checksum 0x8a6cce18, Offset: 0x4470
// Size: 0x44
function function_96fb0ddd(player) {
    self.var_1bf7f0e2 = 1;
    self dodamage(self.health + 666, self.origin, player);
}

// Namespace namespace_cafc107d
// Params 1, eflags: 0x1 linked
// Checksum 0x2ba3ab1f, Offset: 0x44c0
// Size: 0x154
function function_5e58815d(var_132c487f) {
    self endon(#"death");
    level endon(#"intermission");
    if (isdefined(self.sliding) && self.sliding) {
        return;
    }
    self notify(#"hash_3ed54e9c");
    self.is_traversing = 1;
    self notify(#"hash_288b6f93");
    self.sliding = 1;
    self.ignoreall = 1;
    self thread function_56fb8361();
    self setgoalnode(var_132c487f);
    var_2edad3c8 = 3600;
    while (distancesquared(self.origin, var_132c487f.origin) > var_2edad3c8) {
        wait(0.01);
    }
    self thread function_5d40ea94();
    self notify(#"hash_b2707e13");
    self.sliding = 0;
    self.is_traversing = 0;
    self notify(#"hash_af582b8e");
    self thread function_9bb734c9();
}

// Namespace namespace_cafc107d
// Params 0, eflags: 0x1 linked
// Checksum 0xbd9d26, Offset: 0x4620
// Size: 0x24
function function_56fb8361() {
    self zombie_utility::set_zombie_run_cycle("sprint_slide");
}

// Namespace namespace_cafc107d
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x4650
// Size: 0x4
function function_c39787b6() {
    
}

// Namespace namespace_cafc107d
// Params 0, eflags: 0x1 linked
// Checksum 0x4b8af38a, Offset: 0x4660
// Size: 0xa4
function function_316b0a64() {
    level flag::init("monkey_ambient_excited");
    function_1caa925b();
    level.var_dad020fc = struct::get_array("monkey_ambient", "targetname");
    level thread function_96a65a63();
    level thread function_5830565e();
    level thread function_2480dae(4);
}

// Namespace namespace_cafc107d
// Params 0, eflags: 0x1 linked
// Checksum 0x14e98d43, Offset: 0x4710
// Size: 0x140
function function_96a65a63() {
    origin1 = getent("evt_monkey_crowd01_origin", "targetname");
    origin2 = getent("evt_monkey_crowd02_origin", "targetname");
    if (!isdefined(origin1) || !isdefined(origin2)) {
        return;
    }
    while (true) {
        level flag::wait_till("monkey_ambient_excited");
        origin1 playloopsound("evt_monkey_crowd01", 2);
        origin2 playloopsound("evt_monkey_crowd02", 2);
        while (level flag::get("monkey_ambient_excited")) {
            wait(0.1);
        }
        origin1 stoploopsound(3);
        origin2 stoploopsound(3);
    }
}

// Namespace namespace_cafc107d
// Params 1, eflags: 0x1 linked
// Checksum 0xfb7e8522, Offset: 0x4858
// Size: 0x1c0
function function_2480dae(var_cba964d2) {
    var_290d11d1 = "temple_start_zone";
    level.var_70e62f7c = [];
    var_387f7f81 = 0;
    var_1962695e = 1;
    while (true) {
        if (!var_1962695e) {
            util::wait_network_frame();
        }
        if (zone_is_active(var_290d11d1) || var_1962695e) {
            if (level.var_70e62f7c.size == 0 && !var_387f7f81) {
                level.var_dad020fc = function_ee9f00c5(level.var_dad020fc);
                if (level.var_dad020fc.size > 0) {
                    for (i = 0; i < var_cba964d2; i++) {
                        level.var_dad020fc[i] function_39bb6caf();
                        if (!var_1962695e) {
                            util::wait_network_frame();
                        }
                        util::wait_network_frame();
                    }
                }
            }
            if (var_1962695e) {
                while (!zone_is_active(var_290d11d1)) {
                    wait(0.1);
                }
            }
            var_1962695e = 0;
            var_387f7f81 = 1;
            continue;
        }
        var_387f7f81 = 0;
        array::remove_undefined(level.var_70e62f7c);
    }
}

// Namespace namespace_cafc107d
// Params 1, eflags: 0x1 linked
// Checksum 0xa3957ff8, Offset: 0x4a20
// Size: 0x54
function zone_is_active(zone_name) {
    if (!isdefined(level.zones) || !isdefined(level.zones[zone_name]) || !level.zones[zone_name].is_active) {
        return false;
    }
    return true;
}

// Namespace namespace_cafc107d
// Params 0, eflags: 0x1 linked
// Checksum 0xc16be99d, Offset: 0x4a80
// Size: 0x23c
function function_39bb6caf() {
    self.monkey = util::spawn_model("c_zom_dlchd_shangrila_monkey", self.origin, self.angles);
    self.monkey.animname = "monkey";
    self.monkey setcandamage(1);
    self.monkey.v_starting_origin = self.origin;
    self.monkey.var_2e8d47d3 = self.angles;
    self.health = 9999;
    namespace_e822cb43::function_80738220(self.monkey);
    self.monkey.location = self;
    self.monkey.var_a87812f9 = util::spawn_model("tag_origin", self.origin, self.angles);
    if (!isdefined(level.var_70e62f7c)) {
        level.var_70e62f7c = [];
    } else if (!isarray(level.var_70e62f7c)) {
        level.var_70e62f7c = array(level.var_70e62f7c);
    }
    level.var_70e62f7c[level.var_70e62f7c.size] = self.monkey;
    self.monkey function_102d51d2();
    self.monkey thread function_3a013570();
    self.monkey thread function_810a4827();
    self.monkey thread function_5e0dc8cc();
    self.monkey thread function_d7a5f860();
    self.monkey thread function_733d4a3d();
    self.monkey clientfield::set("monkey_ragdoll", 1);
}

// Namespace namespace_cafc107d
// Params 0, eflags: 0x1 linked
// Checksum 0x9bec44d0, Offset: 0x4cc8
// Size: 0xb4
function function_d7a5f860() {
    self endon(#"hash_728a0dce");
    self endon(#"monkey_cleanup");
    level flag::wait_till("zm_temple_connected");
    self.var_a87812f9 notify(#"hash_2ac1782e");
    self useanimtree(#critter);
    self animation::stop(0.2);
    self animation::play("rtrg_ai_zm_dlc5_monkey_calm_idle_loop_03", self.v_starting_origin, self.var_2e8d47d3);
}

// Namespace namespace_cafc107d
// Params 0, eflags: 0x1 linked
// Checksum 0xa93299e7, Offset: 0x4d88
// Size: 0xf4
function function_5e0dc8cc() {
    self endon(#"monkey_cleanup");
    damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags = self waittill(#"damage");
    self.alive = 0;
    self notify(#"hash_728a0dce");
    playsoundatposition("zmb_stealer_death", self.origin);
    self animation::stop();
    self startragdoll();
}

// Namespace namespace_cafc107d
// Params 0, eflags: 0x0
// Checksum 0x24c39bbe, Offset: 0x4e88
// Size: 0x20
function function_7d49834c() {
    self endon(#"monkey_cleanup");
    self endon(#"hash_728a0dce");
    wait(10);
}

// Namespace namespace_cafc107d
// Params 0, eflags: 0x1 linked
// Checksum 0xbcbdf10f, Offset: 0x4eb0
// Size: 0xd0
function function_5830565e() {
    self endon(#"monkey_cleanup");
    self endon(#"hash_728a0dce");
    while (true) {
        powerup = level waittill(#"powerup_dropped");
        level flag::set("monkey_ambient_excited");
        do {
            wait(0.3);
            level.var_d0de9539 = zm_powerups::get_powerups();
            level.var_d0de9539 = array::remove_undefined(level.var_d0de9539);
        } while (level.var_d0de9539.size != 0);
        level flag::clear("monkey_ambient_excited");
    }
}

// Namespace namespace_cafc107d
// Params 0, eflags: 0x1 linked
// Checksum 0x17f02a14, Offset: 0x4f88
// Size: 0x368
function function_810a4827() {
    self endon(#"hash_728a0dce");
    self endon(#"monkey_cleanup");
    if (!isdefined(self.var_188503aa)) {
        self.var_188503aa = [];
        if (!isdefined(self.var_188503aa)) {
            self.var_188503aa = [];
        } else if (!isarray(self.var_188503aa)) {
            self.var_188503aa = array(self.var_188503aa);
        }
        self.var_188503aa[self.var_188503aa.size] = "rtrg_ai_zm_dlc5_monkey_freaked_01";
        if (!isdefined(self.var_188503aa)) {
            self.var_188503aa = [];
        } else if (!isarray(self.var_188503aa)) {
            self.var_188503aa = array(self.var_188503aa);
        }
        self.var_188503aa[self.var_188503aa.size] = "rtrg_ai_zm_dlc5_monkey_freaked_01a";
        if (!isdefined(self.var_188503aa)) {
            self.var_188503aa = [];
        } else if (!isarray(self.var_188503aa)) {
            self.var_188503aa = array(self.var_188503aa);
        }
        self.var_188503aa[self.var_188503aa.size] = "rtrg_ai_zm_dlc5_monkey_freaked_01b";
        if (!isdefined(self.var_188503aa)) {
            self.var_188503aa = [];
        } else if (!isarray(self.var_188503aa)) {
            self.var_188503aa = array(self.var_188503aa);
        }
        self.var_188503aa[self.var_188503aa.size] = "rtrg_ai_zm_dlc5_monkey_freaked_01c";
    }
    while (true) {
        self.var_188503aa = array::randomize(self.var_188503aa);
        level flag::wait_till("monkey_ambient_excited");
        wait(randomfloatrange(0, 1));
        self.excited = 1;
        self thread function_f413c7();
        self.var_a87812f9 notify(#"hash_2ac1782e");
        for (n_index = 0; true; n_index = 0) {
            self animation::stop(0.2);
            self animation::play(self.var_188503aa[n_index], self.v_starting_origin, self.var_2e8d47d3);
            if (!level flag::get("monkey_ambient_excited")) {
                break;
            }
            if (n_index < self.var_188503aa.size - 2) {
                n_index++;
                continue;
            }
        }
        self.excited = 0;
        self thread function_d7a5f860();
    }
}

// Namespace namespace_cafc107d
// Params 0, eflags: 0x1 linked
// Checksum 0x5aaa6460, Offset: 0x52f8
// Size: 0x34
function function_1caa925b() {
    level.var_87f8b6b9 = gettime() + randomfloatrange(3, 6) * 1000;
}

// Namespace namespace_cafc107d
// Params 0, eflags: 0x1 linked
// Checksum 0x4c53a161, Offset: 0x5338
// Size: 0x34
function function_102d51d2() {
    self.next_sound_time = gettime() + randomfloatrange(6, 12) * 1000;
}

// Namespace namespace_cafc107d
// Params 0, eflags: 0x1 linked
// Checksum 0xae7cae88, Offset: 0x5378
// Size: 0x30
function function_4707af51() {
    if (gettime() < level.var_87f8b6b9) {
        return false;
    }
    if (gettime() < self.next_sound_time) {
        return false;
    }
    return true;
}

// Namespace namespace_cafc107d
// Params 0, eflags: 0x1 linked
// Checksum 0x2111173f, Offset: 0x53b0
// Size: 0x88
function function_3a013570() {
    self endon(#"hash_728a0dce");
    self endon(#"monkey_cleanup");
    while (true) {
        if (self function_4707af51()) {
            self thread function_5fe491ec("zmb_stealer_ambient");
            self function_102d51d2();
            function_1caa925b();
        }
        wait(0.1);
    }
}

// Namespace namespace_cafc107d
// Params 0, eflags: 0x1 linked
// Checksum 0x623475eb, Offset: 0x5440
// Size: 0x68
function function_f413c7() {
    self endon(#"hash_728a0dce");
    self endon(#"monkey_cleanup");
    while (self.excited) {
        self thread function_5fe491ec("zmb_stealer_excited");
        wait(randomfloatrange(1.5, 3));
    }
}

// Namespace namespace_cafc107d
// Params 1, eflags: 0x1 linked
// Checksum 0x38765847, Offset: 0x54b0
// Size: 0x78
function function_5fe491ec(soundname) {
    while (isdefined(level.var_36e5f7c2) && level.var_36e5f7c2) {
        util::wait_network_frame();
    }
    level.var_36e5f7c2 = 1;
    self playsound(soundname);
    util::wait_network_frame();
    level.var_36e5f7c2 = 0;
}

// Namespace namespace_cafc107d
// Params 0, eflags: 0x1 linked
// Checksum 0xf07cb6dc, Offset: 0x5530
// Size: 0x84
function function_733d4a3d() {
    var_13cd657b = self util::waittill_any_return("shrunk", "death", "monkey_killed", "monkey_cleanup");
    namespace_e822cb43::function_d705d94f(self);
    if (var_13cd657b == "shrunk") {
        self thread function_f6eabea0();
    }
}

// Namespace namespace_cafc107d
// Params 0, eflags: 0x1 linked
// Checksum 0xd16a3d68, Offset: 0x55c0
// Size: 0x66
function function_fb89ef58() {
    for (i = level.var_70e62f7c.size - 1; i >= 0; i--) {
        monkey = level.var_70e62f7c[i];
        monkey thread function_f6eabea0();
    }
}

// Namespace namespace_cafc107d
// Params 0, eflags: 0x1 linked
// Checksum 0x3cf77c40, Offset: 0x5630
// Size: 0x1a0
function function_b0b5ea7a() {
    self endon(#"death");
    var_c52d1105 = 14400;
    while (true) {
        if (isdefined(self.var_6f24f931) && self.var_6f24f931) {
            util::wait_network_frame();
            continue;
        }
        if (isdefined(level.var_d6a3cc98) && level.var_d6a3cc98.size > 0) {
            for (i = 0; i < level.var_d6a3cc98.size; i++) {
                grenade = level.var_d6a3cc98[i];
                if (!isdefined(grenade) || isdefined(grenade.monkey)) {
                    util::wait_network_frame();
                    continue;
                }
                if (isdefined(self.powerup)) {
                    util::wait_network_frame();
                    continue;
                }
                var_fc2c29a3 = distancesquared(self.origin, grenade.origin);
                if (var_fc2c29a3 <= var_c52d1105) {
                    grenade.monkey = self;
                    self.var_6f24f931 = grenade;
                    self function_9ca2294a();
                    break;
                }
            }
        }
        util::wait_network_frame();
    }
}

// Namespace namespace_cafc107d
// Params 0, eflags: 0x1 linked
// Checksum 0xd652b634, Offset: 0x57d8
// Size: 0x44
function function_9ca2294a() {
    self endon(#"death");
    self notify(#"hash_3ed54e9c");
    self function_9924e38f();
    self thread function_9bb734c9();
}

// Namespace namespace_cafc107d
// Params 0, eflags: 0x1 linked
// Checksum 0xe7c9d3c4, Offset: 0x5828
// Size: 0x228
function function_9924e38f() {
    self endon(#"death");
    var_e133e973 = 1024;
    picked_up = 0;
    while (isdefined(self.var_6f24f931)) {
        self setgoalpos(self.var_6f24f931.origin);
        var_fc2c29a3 = distancesquared(self.origin, self.var_6f24f931.origin);
        if (var_fc2c29a3 <= var_e133e973) {
            self.var_f9b8c18a = self.var_6f24f931.thrower;
            self.var_6f24f931 delete();
            self.var_6f24f931 = undefined;
            picked_up = 1;
        }
        util::wait_network_frame();
    }
    if (picked_up) {
        while (true) {
            self setgoalpos(self.var_f9b8c18a.origin);
            target_dir = self.var_f9b8c18a.origin - self.origin;
            var_bf9b3d0e = anglestoforward(self.angles);
            dot = vectordot(vectornormalize(target_dir), vectornormalize(var_bf9b3d0e));
            if (dot >= 0.5) {
                break;
            }
            util::wait_network_frame();
        }
        self thread function_536415cd(self.var_f9b8c18a);
        self waittill(#"hash_8c6afaf6");
    }
}

// Namespace namespace_cafc107d
// Params 2, eflags: 0x0
// Checksum 0x5f4c4640, Offset: 0x5a58
// Size: 0x184
function function_4334c398(target, animname) {
    self endon(#"death");
    self waittillmatch(animname, "grenade_throw");
    var_1e8168cb = randomintrange(20, 30);
    dir = vectortoangles(target.origin - self.origin);
    dir = (dir[0] - var_1e8168cb, dir[1], dir[2]);
    dir = anglestoforward(dir);
    velocity = dir * 550;
    fuse = randomfloatrange(1, 2);
    var_d2580f11 = self gettagorigin("J_Thumb_RI_1");
    grenade_type = target zm_utility::get_player_lethal_grenade();
    self magicgrenadetype(grenade_type, var_d2580f11, velocity, fuse);
}

// Namespace namespace_cafc107d
// Params 1, eflags: 0x1 linked
// Checksum 0x5254a107, Offset: 0x5be8
// Size: 0x1a
function function_536415cd(target) {
    self notify(#"hash_8c6afaf6");
}

// Namespace namespace_cafc107d
// Params 0, eflags: 0x1 linked
// Checksum 0x732bdb57, Offset: 0x5c10
// Size: 0x128
function function_3bd5290b() {
    self endon(#"death");
    self.attack_player = 1;
    self.attacking_player = 1;
    players = getplayers();
    self.ignore_player = [];
    player = undefined;
    if (isdefined(self.var_c3ff696c) && zombie_utility::is_player_valid(self.var_c3ff696c)) {
        player = self.var_c3ff696c;
    }
    if (isdefined(player)) {
        self.favoriteenemy = player;
        self thread function_7e4d7b7e();
        self function_aaeace69();
        self thread function_8eae2284();
        self thread function_4f048499(self.favoriteenemy);
        self waittill(#"hash_f6876ed2");
    }
}

// Namespace namespace_cafc107d
// Params 1, eflags: 0x1 linked
// Checksum 0xcf93ebe0, Offset: 0x5d40
// Size: 0x3c
function function_4f048499(player) {
    self function_be4da6f5(player);
    self function_1a75c26d();
}

// Namespace namespace_cafc107d
// Params 1, eflags: 0x1 linked
// Checksum 0xcd0124a7, Offset: 0x5d88
// Size: 0x90
function function_be4da6f5(player) {
    self endon(#"death");
    self endon(#"hash_3ed54e9c");
    var_2d855f09 = gettime() + 20000;
    while (var_2d855f09 > gettime()) {
        if (!zombie_utility::is_player_valid(player)) {
            break;
        }
        if (isdefined(self.var_a6542123) && self.var_a6542123 >= 1) {
            break;
        }
        wait(0.1);
    }
}

// Namespace namespace_cafc107d
// Params 0, eflags: 0x1 linked
// Checksum 0xddce5699, Offset: 0x5e20
// Size: 0x48
function function_1a75c26d() {
    self notify(#"hash_f6876ed2");
    self.ignoreall = 1;
    if (isalive(self)) {
        self.favoriteenemy = undefined;
        self.attacking_player = 0;
    }
}

// Namespace namespace_cafc107d
// Params 0, eflags: 0x1 linked
// Checksum 0xbea096fc, Offset: 0x5e70
// Size: 0xa0
function function_8eae2284() {
    self endon(#"death");
    self endon(#"hash_f6876ed2");
    self.ignoreall = 0;
    self.meleeattackdist = 64;
    while (isdefined(self.favoriteenemy)) {
        self.goalradius = 32;
        self orientmode("face default");
        self setgoalpos(self.favoriteenemy.origin);
        util::wait_network_frame();
    }
}

// Namespace namespace_cafc107d
// Params 1, eflags: 0x1 linked
// Checksum 0x9b540e7b, Offset: 0x5f18
// Size: 0xc8
function function_187afb04(player) {
    self endon(#"death");
    damage = self.meleedamage;
    if (!isdefined(self.var_a6542123)) {
        self.var_a6542123 = 0;
    }
    self.var_a6542123++;
    if (isdefined(player) && player.score > 0) {
        var_ff6a0b0 = int(min(player.score, 50));
        player zm_score::minus_to_player_score(var_ff6a0b0);
    }
    return damage;
}

// Namespace namespace_cafc107d
// Params 0, eflags: 0x1 linked
// Checksum 0xd071502c, Offset: 0x5fe8
// Size: 0x58
function function_7e4d7b7e() {
    self endon(#"death");
    self endon(#"hash_f6876ed2");
    while (true) {
        self playsound("zmb_stealer_attack");
        wait(randomfloatrange(2, 4));
    }
}

